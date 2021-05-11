package example
import data.example.s3


# ruleOutcome is the main query that will be executed in all the rego files
ruleOutcome = {
  "name": "S3 CIS Encryption",
  "category": "input.rule_details.category",
  #"sub_category": input.rule_details.sub_category,
  "state": state,
  "severity": severeness,
  "affected_resource_name": "input.resource_name",
  "affected_resource_id": "input.resource_id",
  "affected_resource_type": "aws.S3",
  "details": {"explanation": explainations[severeness],
               #This convention helps extracting object from the composite value
               #using the String literal or dynamic parameters,
               #Eg: recommendations["Critical"] as compared to recommendations.Critical
              "recommendation": recommendations[severeness],
              "encryption_algorithm": s3.encryption_algorithm }
}


default state = "fail"
default severity = "Critical"




explainations = {
  "Critical": "The Encryption Key is expired or no encryption is configured",
  "High":  "high_alert_explaination",
  "Medium":  "explaination_str",
  "Low": "explaination_str",
  "None": "Encryption Enabled"
}

recommendations = {
  "Critical": "Please renew your key material",
  "High": "",
  "Medium": "Please renew your key material",
  "Low": "Please renew your key material",
  "None": "S3 is Configured properly, No effort needed",
  "Unknown": "Unknown"
}


state = "allowed"{
    s3.config_allowed
    s3.encryption_algorithm_allowed
}else = "fail"{
    s3.config_not_allowed
}else = "partially allowed"{
    s3.config_allowed
    s3.encryption_algorithm_not_allowed
}

severeness = "None"{
    s3.allow_config
    s3.allow_algorithm
}else = "High"



