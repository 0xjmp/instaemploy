require 'spec_helper'

describe GitWorker do
  let(:project){create(:project)}

  context GitWorker::Upload do
    it { is_expected.to be_processed_in :git }
    it { is_expected.to be_retryable 4 }

    it 'should perform_async' do
      GitWorker::Upload.perform_async(project.id)
      expect(GitWorker::Upload.jobs.size).to eq 2
    end

    it 'should perform' do
      GitWorker::Upload.new.perform(project.id)
      project.reload
      expect(project.git_url).to be
    end

    context 'UploadWorker' do
    end
  end

  context GitWorker::Remove do
    it { is_expected.to be_processed_in :git }
    it { is_expected.to be_retryable 2 }

    it 'should perform_async' do
      GitWorker::Remove.perform_async(project.id)
      expect(GitWorker::Remove.jobs.size).to eq 1
    end

    it 'should perform' do
      GitWorker::Remove.new.perform(project.id)
      project.reload
      expect(project.git_url).to eq nil
    end
  end
end