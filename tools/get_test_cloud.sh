#!/usr/bin/env bash

function test_cloud
{
   CLOUD_DETAILS=$(curl -X POST  \-H 'Content-type:application/json' \https://sub-account-testing.cloudinary.com/create_sub_account \--data '{"prefix" : "android-test-cloud"}')
   
   APIKEY=$(echo "${CLOUD_DETAILS}" |  python3 -c 'import json,sys;c=json.load(sys.stdin)["payload"];print("%s" % (c["cloudApiKey"]))')
   APISECRET=$(echo "${CLOUD_DETAILS}" |  python3 -c 'import json,sys;c=json.load(sys.stdin)["payload"];print("%s" % (c["cloudApiSecret"]))')
   CLOUD_NAME=$(echo "${CLOUD_DETAILS}" |  python3 -c 'import json,sys;c=json.load(sys.stdin)["payload"];print("%s" % (c["cloudName"]))')
   CLOUDINARY_URL=$(echo ${CLOUD_DETAILS} | python3 -c 'import json,sys;c=json.load(sys.stdin)["payload"];print("cloudinary://%s:%s@%s" % (c["cloudApiKey"], c["cloudApiSecret"], c["cloudName"]))')
   curl \
   -d "name=cloudinary_java_test&unsigned=true" \
  -X POST \
  https://"${APIKEY}":"${APISECRET}"@api.cloudinary.com/v1_1/"${CLOUD_NAME}"/upload_presets > /dev/null
  echo "${CLOUDINARY_URL}"
}

test_cloud
