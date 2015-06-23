group "app_gjcase_prod", path: path do
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
