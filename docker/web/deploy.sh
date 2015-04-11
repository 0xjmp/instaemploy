VERSION_LABEL=$CIRCLE_SHA1
RUN_FILE=$VERSION_LABEL.zip
NAMESPACE=app # What folder the zip should be stored on s3

zip -r $VERSION_LABEL *
aws s3 cp $RUN_FILE s3://$S3_BUCKET/$NAMESPACE/$RUN_FILE --region $EB_REGION
rm $RUN_FILE

# Replace the 'latest' application version
aws elasticbeanstalk delete-application-version --application-name $EB_APPLICATION_NAME \
  --version-label $VERSION_LABEL --region $EB_REGION
aws elasticbeanstalk create-application-version --application-name $EB_APPLICATION_NAME \
  --version-label $VERSION_LABEL --region $EB_REGION \
  --source-bundle S3Bucket=$S3_BUCKET,S3Key=$NAMESPACE/$RUN_FILE

# Call for an environment update
aws elasticbeanstalk update-environment --environment-name $EB_ENVIRONMENT \
  --version-label $VERSION_LABEL --region $EB_REGION