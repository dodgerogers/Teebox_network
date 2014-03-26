class SNSConfirmation
  def self.confirm(arn, token)
    sns = Fog::AWS::SNS.new(aws_access_key_id: CONFIG[:aws_access_key_id], aws_secret_access_key: CONFIG[:aws_secret_key_id])
    sns.confirm_subscription(arn, token)
  end
end