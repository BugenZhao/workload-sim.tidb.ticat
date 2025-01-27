set -euo pipefail

here=`cd $(dirname ${BASH_SOURCE[0]}) && pwd`
. "${here}/../helper/helper.bash"

env_file="${1}/env"
env=`cat "${env_file}"`
shift

db=`must_env_val "${env}" 'sql-masker.mask.db'`

src_dir=`must_env_val "${env}" 'lightning.data-source-dir'`
store_dir=`must_env_val "${env}" 'my-rep.store.dir'`
ddl_dir="${store_dir}/ddl"

mkdir -p "${ddl_dir}"
cp -v "${src_dir}/${db}."*"-schema.sql" "${ddl_dir}"

echo "[:)] set 'sql-masker.mask.ddl-dir' to ${ddl_dir}"
echo "sql-masker.mask.ddl-dir=${ddl_dir}" >> "${env_file}"
