group "acmesmith_read", path: path do
  policy "allow_s3_kosendj-acme" do
    {
      "Version"=>"2012-10-17",
      "Statement" => [
        {
          "Effect" => "Allow",
          "Action" => [
            "s3:GetObject",
          ],
          "Resource" => %w(arn:aws:s3:::kosendj-acme/private-prod/certs/*),
        },
      ]
    }
  end
end
