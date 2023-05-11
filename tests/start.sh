# Create tests default directories
mkdir -p ${PRYV_CONF_ROOT}/pryv/mongodb/backup
mkdir -p ${PRYV_CONF_ROOT}/pryv/mongodb/log
mkdir -p ${PRYV_CONF_ROOT}/pryv/mongodb/data

export PRYV_CONF_ROOT=~/dev-release-packaging/tests/
docker-compose -f ${PRYV_CONF_ROOT}/pryv.yml up