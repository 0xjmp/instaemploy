# Be sure to restart your server when you modify this file.
#
# Points are a simple integer value which are given to "meritable" resources
# according to rules in +app/models/merit/point_rules.rb+. They are given on
# actions-triggered, either to the action user or to the method (or array of
# methods) defined in the +:to+ option.
#
# 'score' method may accept a block which evaluates to boolean
# (recieves the object as parameter)

module Merit
  class PointRules
    include Merit::PointRulesMethods

    def initialize
      # score 10, :on => 'users#create' do |user|
      #   user.bio.present?
      # end
      #
      # score 15, :on => 'reviews#create', :to => [:reviewer, :reviewed]
      #
      # score 20, :on => [
      #   'comments#create',
      #   'photos#create'
      # ]
      #
      # score -10, :on => 'comments#destroy'

      score 500, on: 'api/v1/users/invitations#create'
      score (-500), on: 'api/v1/users/invitations#destroy'

      next_bid_score = lambda do |bid|
        case bid.state
          when 'started'
            100
          when 'completed'
            500
        end
      end
      score next_bid_score, on: 'api/v1/bids#next', model_name: 'Bid'
      score (-100), on: 'api/v1/bids#cancel', model_name: 'Bid'

      score 10, on: 'api/v1/projects#follow', model_name: 'User'
      score (-10), on: 'api/v1/projects#unfollow', model_name: 'User'

      score 250, on: 'api/v1/projects#create', model_name: 'User'
      score (-250), on: 'api/v1/projects#destroy', model_name: 'User'
    end
  end
end
