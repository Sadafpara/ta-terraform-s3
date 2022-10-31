resource "aws_sns_topic" "s3_sns_topic" {
  name = "s3-event-notification-topic"

  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": { "Service": "s3.amazonaws.com" },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:s3-event-notification-topic",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.ta_s3_bucket.arn}"}
        }
    }]
}
POLICY
}


resource "aws_s3_bucket_notification" "s3_sns_notification" {
  bucket = aws_s3_bucket.ta_s3_bucket.id

  topic {
    topic_arn     = aws_sns_topic.s3_sns_topic.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".log"
  }
}