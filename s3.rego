package example.s3


default encryption_algorithm = "Not Identified"
# encryption.config validation rule to set the state and severity for S3

config_allowed {
      input.awsS3.Encryption.ServerSideEncryptionConfiguration != null
}

config_not_allowed {
      input.awsS3.Encryption.ServerSideEncryptionConfiguration == null
}

encryption_algorithm_allowed{
     some i,j
     algo := encrypt_algo_options[j]
     input.awsS3.Encryption.ServerSideEncryptionConfiguration.Rules[i].ApplyServerSideEncryptionByDefault.SSEAlgorithm == algo
}

encryption_algorithm_not_allowed{
        some i,j
        algo := encrypt_algo_options[j]
        input.awsS3.Encryption.ServerSideEncryptionConfiguration.Rules[i].ApplyServerSideEncryptionByDefault.SSEAlgorithm != algo
}

encryption_algorithm = algo {
        some i,j
        algo := encrypt_algo_options[j]
        encryption_algorithm := algo
        input.awsS3.Encryption.ServerSideEncryptionConfiguration.Rules[i].ApplyServerSideEncryptionByDefault.SSEAlgorithm == algo
}

encrypt_algo_options = {
    "AES:256","aws:kms"
}
