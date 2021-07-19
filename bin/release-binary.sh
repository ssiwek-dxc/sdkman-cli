#!/usr/bin/env bash

MONGO_URL="$1"
MONGO_USERNAME="$2"
MONGO_PASSWORD="$3"
PARAM_1="$4"
PARAM_2="$5"

echo "Mongo URL: $MONGO_URL"

if [[ -z "$MONGO_USERNAME" || -z "$MONGO_PASSWORD" ]]; then
	echo "No mongo credentials so doing nothing..."
	exit 1
fi

if [[ "$PARAM_2" == 'stable' ]]; then
	FIELD="stableCliVersion"
	VERSION="$PARAM_1"
elif [[ "$PARAM_2" == 'latest' ]]; then
	FIELD="betaCliVersion"
	VERSION="latest+$PARAM_1"
else
	exit 1
fi

echo "Release: $FIELD as $VERSION"

mongo "${MONGO_URL}" --username="${MONGO_USERNAME}" --password="${MONGO_PASSWORD}" -eval "db.application.updateOne({}, {\$set: { \"$FIELD\": \"$VERSION\"}});"
