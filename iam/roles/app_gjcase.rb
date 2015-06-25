role "AppGjcase", path: path do
  instance_profiles(
    "AppGjcase"
  )

  assume_role_policy_document do
    {"Version"=>"2012-10-17",
     "Statement"=>
      [{"Sid"=>"",
        "Effect"=>"Allow",
        "Principal"=>{"Service"=>"ec2.amazonaws.com"},
        "Action"=>"sts:AssumeRole"}]}
  end

  policy "allow_s3_gjcase-prod" do
    {
      "Version"=>"2012-10-17",
      "Statement" => [
        {
          "Effect" => "Allow",
          "Action" => [
            "s3:*",
          ],
          "Resource" => %w(arn:aws:s3:::gjcase-prod arn:aws:s3:::gjcase-prod/*),
        },
      ]
    }
  end
end
instance_profile "AppGjcase", path: path
