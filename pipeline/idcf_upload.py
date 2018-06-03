# Copyright 2018 Coins Handbook Team. All Rights Reserved.
# Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file
# except in compliance with the License. A copy of the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is distributed on an "AS IS"
# BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under the License.
from __future__ import print_function
import os
import sys
import argparse
import boto3
from botocore.exceptions import ClientError

def upload_to_idcf(access_key, secret_key, bucket, artefact, bucket_key):
    """
    Uploads an artefact to IDCF
    """

    endpoint = "https://ds.jp-east.idcfcloud.com"

    try:
        client = boto3.client(
            service_name = "s3",
            aws_access_key_id = access_key,
            aws_secret_access_key = secret_key,
            endpoint_url = endpoint
        )
    except ClientError as err:
        print("Failed to create boto3 client.\n" + str(err))
        return False
    try:
        client.put_object(
            ACL = "public-read",
            Body = open(artefact, 'rb'),
            Bucket = bucket,
            Key = bucket_key,
            ContentType = 'application/pdf'
        )
    except ClientError as err:
        print("Failed to upload artefact to IDCF.\n" + str(err))
        return False
    except IOError as err:
        print("Failed to access artefact in this directory.\n" + str(err))
        return False
    return True


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument("access_key", help="Name of the existing IDCF bucket")
    parser.add_argument("secret_key", help="Name of the artefact to be uploaded to IDCF")
    parser.add_argument("bucket", help="Name of the existing IDCF bucket")
    parser.add_argument("artefact", help="Name of the artefact to be uploaded to IDCF")
    parser.add_argument("bucket_key", help="Name of the IDCF Bucket key")
    args = parser.parse_args()

    if not upload_to_idcf(args.access_key, args.secret_key, args.bucket, args.artefact, args.bucket_key):
        sys.exit(1)

    print("The file at https://handbook.ds.jp-east.idcfcloud.com/" + args.bucket_key + "\n")

if __name__ == "__main__":
    main()
