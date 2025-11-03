#!/usr/bin/env nextflow
// hash:sha256:87a6cff47cced2d3a3132e078f88703769e15a5a9119616ace6e5e7ea73f538d

// capsule - aind-opto-fiber-benchmark-nwb-base
process capsule_aind_opto_fiber_benchmark_nwb_base_1 {
	tag 'capsule-9866173'
	container "$REGISTRY_HOST/published/cc2de901-6fcd-47bf-9160-cb413b109dc5:v3"

	cpus 1
	memory '7.5 GB'

	input:
	path 'capsule/data/raw_data'

	output:
	path 'capsule/results/*', emit: to_capsule_aind_fip_dff_2_3

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=cc2de901-6fcd-47bf-9160-cb413b109dc5
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9866173.git" capsule-repo
	else
		git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9866173.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-fip-dff
process capsule_aind_fip_dff_2 {
	tag 'capsule-1001867'
	container "$REGISTRY_HOST/published/603a2149-6281-4a7b-bbd6-ff50ca0e064e:v13"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/fiber_raw_data'
	path 'capsule/data/nwb/'

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=603a2149-6281-4a7b-bbd6-ff50ca0e064e
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v13.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1001867.git" capsule-repo
	else
		git clone --branch v13.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1001867.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

params.raw_data_url = 's3://aind-open-data/behavior_809491_2025-10-21_09-37-59'

workflow {
	// input data
	raw_data_to_aind_opto_fiber_benchmark_nwb_base_1 = Channel.fromPath(params.raw_data_url + "/", type: 'any')
	raw_data_to_aind_fip_dff_2 = Channel.fromPath(params.raw_data_url + "/", type: 'any')

	// run processes
	capsule_aind_opto_fiber_benchmark_nwb_base_1(raw_data_to_aind_opto_fiber_benchmark_nwb_base_1.collect())
	capsule_aind_fip_dff_2(raw_data_to_aind_fip_dff_2.collect(), capsule_aind_opto_fiber_benchmark_nwb_base_1.out.to_capsule_aind_fip_dff_2_3.collect())
}
