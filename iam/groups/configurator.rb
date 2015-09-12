group "configurator", path: path do
  policy "allow_s3_kosendj-config" do
    {
      "Version"=>"2012-10-17",
      "Statement" => [
        {
          "Effect" => "Allow",
          "Action" => [
            "s3:*",
          ],
          "Resource" => %w(arn:aws:s3:::kosendj-config arn:aws:s3:::kosendj-config/*),
        },
      ]
    }
  end
end
