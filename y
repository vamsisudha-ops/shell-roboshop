"Groups": [],
    "Instances": [
        {
            "AmiLaunchIndex": 0,
            "ImageId": "ami-0220d79f3f480ecf5",
            "InstanceId": "i-0794903652fcfd43d",
            "InstanceType": "t3.micro",
            "LaunchTime": "2026-03-13T15:21:49+00:00",
            "Monitoring": {
                "State": "disabled"
            },
            "Placement": {
                "AvailabilityZone": "us-east-1b",
                "GroupName": "",
                "Tenancy": "default"
            },
            "PrivateDnsName": "ip-172-31-13-114.ec2.internal",
            "PrivateIpAddress": "172.31.13.114",
            "ProductCodes": [],
            "PublicDnsName": "",
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "StateTransitionReason": "",
            "SubnetId": "subnet-08edc8af5812dbe4c",
            "VpcId": "vpc-0d09f70cbd4bdf618",
            "Architecture": "x86_64",
            "BlockDeviceMappings": [],
            "ClientToken": "4b63a0d6-fe6b-46a9-9e3a-254ae8621d69",
            "EbsOptimized": false,
            "EnaSupport": true,
            "Hypervisor": "xen",
            "NetworkInterfaces": [
                {
                    "Attachment": {
                        "AttachTime": "2026-03-13T15:21:49+00:00",
                        "AttachmentId": "eni-attach-04bf51d78b9aa9ec4",
                        "DeleteOnTermination": true,
                        "DeviceIndex": 0,
                        "Status": "attaching",
                        "NetworkCardIndex": 0
                    },
                    "Description": "",
                    "Groups": [
                        {
                            "GroupName": "allow-all",
                            "GroupId": "sg-01d850127f71e236f"
                        }
                    ],
                    "Ipv6Addresses": [],
                    "MacAddress": "02:16:01:08:78:1f",
                    "NetworkInterfaceId": "eni-033a2e581039645f2",
                    "OwnerId": "841149292133",
                    "PrivateDnsName": "ip-172-31-13-114.ec2.internal",
                    "PrivateIpAddress": "172.31.13.114",
                    "PrivateIpAddresses": [
                        {
                            "Primary": true,
                            "PrivateDnsName": "ip-172-31-13-114.ec2.internal",
                            "PrivateIpAddress": "172.31.13.114"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Status": "in-use",
                    "SubnetId": "subnet-08edc8af5812dbe4c",
                    "VpcId": "vpc-0d09f70cbd4bdf618",
                    "InterfaceType": "interface"
                }
            ],
            "RootDeviceName": "/dev/sda1",
            "RootDeviceType": "ebs",
            "SecurityGroups": [
                {
                    "GroupName": "allow-all",
                    "GroupId": "sg-01d850127f71e236f"
                }
            ],
            "SourceDestCheck": true,
            "StateReason": {
                "Code": "pending",
                "Message": "pending"
            },
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "Test"
                }
            ],
            "VirtualizationType": "hvm",
            "CpuOptions": {
                "CoreCount": 1,
                "ThreadsPerCore": 2
            },
            "CapacityReservationSpecification": {
                "CapacityReservationPreference": "open"
            },
            "MetadataOptions": {
                "State": "pending",
                "HttpTokens": "optional",
                "HttpPutResponseHopLimit": 1,
                "HttpEndpoint": "enabled",
                "HttpProtocolIpv6": "disabled",
                "InstanceMetadataTags": "disabled"
            },
            "EnclaveOptions": {
                "Enabled": false
            },
            "BootMode": "uefi-preferred",
            "PrivateDnsNameOptions": {
                "HostnameType": "ip-name",
                "EnableResourceNameDnsARecord": false,
                "EnableResourceNameDnsAAAARecord": false
            },
            "MaintenanceOptions": {
                "AutoRecovery": "default"
            },
            "CurrentInstanceBootMode": "uefi"
        }
    ],
    "OwnerId": "841149292133",
    "ReservationId": "r-0dbb4fa1a067b68ac"
}
