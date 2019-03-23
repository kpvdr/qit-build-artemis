#! /bin/bash

. ./scripts/common.sh

cd ${GIT_DIR}
mvn -DskipTests package

DISTRIBUTION_DIR="artemis-distribution/target"

TAR_FILE=`ls ${DISTRIBUTION_DIR}/*bin.tar.gz`
tar -xzf ${TAR_FILE}

BASE_NAME=`ls -d apache-artemis*`
ARTEMIS_PATH=bin/artemis
BROKER_USER="guest"
BROKER_USER_PW="guest"
BROKER_OPTS="--allow-anonymous --user ${BROKER_USER} --password ${BROKER_USER_PW}"
INSTANCE_DIR="broker"
BROKER_EXEC="${INSTANCE_DIR}/bin/artemis"

./${BASE_NAME}/${ARTEMIS_PATH} create ${BROKER_OPTS} ${INSTANCE_DIR}
if [ ! -e ${BROKER_EXEC} ]; then
    echo "ERROR: Artemis executable ${BROKER_EXEC} not found."
    exit 1
fi

ARTEMIS_CONF_FILE=${INSTANCE_DIR}/etc/broker.xml
D2N_ARTEMIS_CONF_FILE=${INSTANCE_DIR}/etc/broker.d2n.xml
cp ${ARTEMIS_CONF_FILE} ${D2N_ARTEMIS_CONF_FILE}
sed -i -f ../artemis.sed ${ARTEMIS_CONF_FILE}
sed -i -f ../artemis.d2n.sed ${D2N_ARTEMIS_CONF_FILE}

cd ..
ln -s ${GIT_DIR}/broker
