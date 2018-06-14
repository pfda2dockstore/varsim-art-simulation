# Generated by precisionFDA exporter (v1.0.3) on 2018-06-14 04:00:28 +0000
# The asset download links in this file are valid only for 24h.

# Exported app: varsim-art-simulation, revision: 16, authored by: marghoob.mohiyuddin
# https://precision.fda.gov/apps/app-Bv82fG00xb1k95pjZ0gqBzqQ

# For more information please consult the app export section in the precisionFDA docs

# Start with Ubuntu 14.04 base image
FROM ubuntu:14.04

# Install default precisionFDA Ubuntu packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
	aria2 \
	byobu \
	cmake \
	cpanminus \
	curl \
	dstat \
	g++ \
	git \
	htop \
	libboost-all-dev \
	libcurl4-openssl-dev \
	libncurses5-dev \
	make \
	perl \
	pypy \
	python-dev \
	python-pip \
	r-base \
	ruby1.9.3 \
	wget \
	xz-utils

# Install default precisionFDA python packages
RUN pip install \
	requests==2.5.0 \
	futures==2.2.0 \
	setuptools==10.2

# Add DNAnexus repo to apt-get
RUN /bin/bash -c "echo 'deb http://dnanexus-apt-prod.s3.amazonaws.com/ubuntu trusty/amd64/' > /etc/apt/sources.list.d/dnanexus.list"
RUN /bin/bash -c "echo 'deb http://dnanexus-apt-prod.s3.amazonaws.com/ubuntu trusty/all/' >> /etc/apt/sources.list.d/dnanexus.list"
RUN curl https://wiki.dnanexus.com/images/files/ubuntu-signing-key.gpg | apt-key add -

# Install app-specific Ubuntu packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
	openjdk-7-jre-headless

# Download app assets
RUN curl https://dl.dnanex.us/F/D/90Vx0kb56zPP6FV5k141PB5JK6Vb1Q2QpyPX8036/art-chocolatecherrycake.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/73Z30jV9zJfjYz49Y4pjyXyYBpyBv3B11k2x49gX/clinvar-grch37-20151102.tar | tar xf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/24fq1BV830Xbf44QyzBP9YYVX5ypF82f2p89JKqX/grch37-fasta.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/2ff72yF5zgGv8XB317QZqXf252bGB797fqy18GvP/htslib-1.2.1.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/VQGPK2ggVvxkzGkQF80yJq79zgy7vj63p5Yk8xq4/picard-tools-1.141.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/VkKB6yp0xgJp0p81pPK4J0zkGzJGJPp0g3kJ3Y80/small-ref.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/YPqk76kQKgPBKZJfjg0f9zP61gYK1v6jYJp7X3Vz/varsim-0.5.3.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions

# Download helper executables
RUN curl https://dl.dnanex.us/F/D/0K8P4zZvjq9vQ6qV0b6QqY1z2zvfZ0QKQP4gjBXp/emit-1.0.tar.gz | tar xzf - -C /usr/bin/ --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/bByKQvv1F7BFP3xXPgYXZPZjkXj9V684VPz8gb7p/run-1.2.tar.gz | tar xzf - -C /usr/bin/ --no-same-owner --no-same-permissions

# Write app spec and code to root folder
RUN ["/bin/bash","-c","echo -E \\{\\\"spec\\\":\\{\\\"input_spec\\\":\\[\\{\\\"name\\\":\\\"number_of_snvs\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Number\\ of\\ SNVs\\\",\\\"help\\\":\\\"The\\ number\\ of\\ SNVs\\ to\\ sample\\ sampling\\ VCF\\\",\\\"default\\\":100\\},\\{\\\"name\\\":\\\"read_length\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Read\\ length\\\",\\\"help\\\":\\\"The\\ length\\ of\\ each\\ simulated\\ read.\\\",\\\"default\\\":150\\},\\{\\\"name\\\":\\\"sequencing_system\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Sequencing\\ system\\\",\\\"help\\\":\\\"The\\ sequencing\\ system\\ to\\ simulate.\\\",\\\"default\\\":\\\"HiSeq\\ 2500\\\",\\\"choices\\\":\\[\\\"Genome\\ Analyzer\\ I\\\",\\\"Genome\\ Analyzer\\ II\\\",\\\"HiSeq\\ 1000\\\",\\\"HiSeq\\ 2000\\\",\\\"HiSeq\\ 2500\\\",\\\"MiSeq\\\"\\]\\},\\{\\\"name\\\":\\\"mean_fragment_size\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Mean\\ fragment\\ size\\\",\\\"help\\\":\\\"The\\ mean\\ size\\ of\\ the\\ simulated\\ sequenced\\ DNA\\ fragments.\\ That\\ is,\\ this\\ is\\ the\\ distance\\ between\\ the\\ outer\\ edges\\ of\\ each\\ read.\\\",\\\"default\\\":500\\},\\{\\\"name\\\":\\\"stddev_fragment_size\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Standard\\ deviation\\ of\\ fragments\\ size\\\",\\\"help\\\":\\\"The\\ standard\\ deviation\\ of\\ simulated\\ DNA\\ fragment\\ sizes.\\\",\\\"default\\\":50\\},\\{\\\"name\\\":\\\"output_name\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Output\\ name\\\",\\\"help\\\":\\\"A\\ name\\ after\\ which\\ the\\ output\\ files\\ will\\ be\\ called\\ \\(name_1.fastq.gz,\\ name.vcf.gz,\\ etc.\\)\\\"\\},\\{\\\"name\\\":\\\"refname\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Reference\\ name\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":\\\"grch37\\\",\\\"choices\\\":\\[\\\"small-ref\\\",\\\"grch37\\\"\\]\\},\\{\\\"name\\\":\\\"coverage\\\",\\\"class\\\":\\\"float\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Coverage\\\",\\\"help\\\":\\\"Fold\\ level\\ coverage\\ to\\ simulate\\\",\\\"default\\\":10\\},\\{\\\"name\\\":\\\"sampling_vcf\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Sampling\\ VCF\\\",\\\"help\\\":\\\"VCF\\ to\\ sample\\ variants\\ from.\\ \\ Example\\ files\\ could\\ be\\ dbSNP,\\ clinvar.\\\"\\},\\{\\\"name\\\":\\\"nonsampling_vcf\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Non-sampling\\ VCF\\\",\\\"help\\\":\\\"Variants\\ in\\ addition\\ to\\ sampling\\ VCF\\\"\\},\\{\\\"name\\\":\\\"varsim_other_opts\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Other\\ VarSim\\ options\\\",\\\"help\\\":\\\"Other\\ options\\ for\\ varsim.py\\ can\\ be\\ put\\ here\\\"\\}\\],\\\"output_spec\\\":\\[\\{\\\"name\\\":\\\"simulated_reads1\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Simulated\\ FASTQ\\ first\\ mates\\\",\\\"help\\\":\\\"The\\ gzipped\\ FASTQ\\ containing\\ the\\ first\\ mates.\\\"\\},\\{\\\"name\\\":\\\"simulated_reads2\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Simulated\\ FASTQ\\ second\\ mates\\\",\\\"help\\\":\\\"The\\ gzipped\\ FASTQ\\ containing\\ the\\ second\\ mates.\\\"\\},\\{\\\"name\\\":\\\"truth_vcfgz\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Simulated\\ variants\\\",\\\"help\\\":\\\"A\\ bgzipped\\ VCF\\ file\\ containing\\ the\\ simulated\\ variants.\\\"\\},\\{\\\"name\\\":\\\"truth_tbi\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Simulated\\ variants\\ index\\\",\\\"help\\\":\\\"The\\ associated\\ TBI\\ file\\ for\\ the\\ simulated\\ variants.\\\"\\},\\{\\\"name\\\":\\\"log_targz\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Log\\ directory\\ archived\\\",\\\"help\\\":\\\"The\\ log\\ files\\ from\\ VarSim\\\"\\}\\],\\\"internet_access\\\":false,\\\"instance_type\\\":\\\"baseline-32\\\"\\},\\\"assets\\\":\\[\\\"file-BkKXJy00qVb121BVxJg3qBYy\\\",\\\"file-BkKXx4Q0qVb5kJxP20xQ71BZ\\\",\\\"file-Bk5xvzQ0qVb5k0VYzZQG7BXJ\\\",\\\"file-Bk5K5zQ0qVb7ZjyyzjpB4F9g\\\",\\\"file-BkXzv480X24QKx39JQ4v5KBq\\\",\\\"file-BkV0z680X24xZqgQZ4PyqY5p\\\",\\\"file-Bkb1Y1j0X24z74kp0440Pgxv\\\"\\],\\\"packages\\\":\\[\\\"openjdk-7-jre-headless\\\"\\]\\} \u003e /spec.json"]
RUN ["/bin/bash","-c","echo -E \\{\\\"code\\\":\\\"case\\ \\\\\\\"\\$sequencing_system\\\\\\\"\\ in\\\\n\\ \\ \\ \\ \\\\\\\"Genome\\ Analyzer\\ I\\\\\\\"\\)\\\\n\\ \\ \\ \\ \\ \\ \\ \\ art_ss\\+\\=\\\\\\\"GA1\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ \\ \\ \\;\\;\\\\n\\ \\ \\ \\ \\\\\\\"Genome\\ Analyzer\\ II\\\\\\\"\\)\\\\n\\ \\ \\ \\ \\ \\ \\ \\ art_ss\\+\\=\\\\\\\"GA2\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ \\ \\ \\;\\;\\\\n\\ \\ \\ \\ \\\\\\\"HiSeq\\ 1000\\\\\\\"\\)\\\\n\\ \\ \\ \\ \\ \\ \\ \\ art_ss\\+\\=\\\\\\\"HS10\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ \\ \\ \\;\\;\\\\n\\ \\ \\ \\ \\\\\\\"HiSeq\\ 2000\\\\\\\"\\)\\\\n\\ \\ \\ \\ \\ \\ \\ \\ art_ss\\+\\=\\\\\\\"HS20\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ \\ \\ \\;\\;\\\\n\\ \\ \\ \\ \\\\\\\"HiSeq\\ 2500\\\\\\\"\\)\\\\n\\ \\ \\ \\ \\ \\ \\ \\ art_ss\\+\\=\\\\\\\"HS25\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ \\ \\ \\;\\;\\\\n\\ \\ \\ \\ \\\\\\\"MiSeq\\\\\\\"\\)\\\\n\\ \\ \\ \\ \\ \\ \\ \\ art_ss\\+\\=\\\\\\\"MS\\\\\\\"\\\\nesac\\\\n\\\\nsampling_opts\\=\\\\\\\"--disable_rand_vcf\\\\\\\"\\\\n\\[\\ \\!\\ -z\\ \\\\\\\"\\$sampling_vcf\\\\\\\"\\ \\]\\ \\\\u0026\\\\u0026\\ sampling_opts\\=\\\\\\\"--vc_in_vcf\\ \\$sampling_vcf_path\\\\\\\"\\\\n\\[\\ \\!\\ -z\\ \\\\\\\"\\$nonsampling_vcf\\\\\\\"\\ \\]\\ \\\\u0026\\\\u0026\\ nonsampling_opts\\=\\\\\\\"--vcfs\\ \\$nonsampling_vcf_path\\\\\\\"\\\\n\\[\\ -z\\ \\\\\\\"\\$sampling_vcf\\\\\\\"\\ -a\\ -z\\ \\\\\\\"\\$nonsampling_vcf\\\\\\\"\\ \\]\\ \\\\u0026\\\\u0026\\ echo\\ \\\\\\\"Need\\ at\\ least\\ one\\ input\\ VCF\\\\\\\"\\ \\\\u0026\\\\u0026\\ exit\\ 1\\\\n\\\\nvarsim.py\\ \\\\\\\\\\\\n\\ \\ \\ \\ --reference\\ \\$refname.fa\\ \\\\\\\\\\\\n\\ \\ \\ \\ --read_length\\ \\\\\\\"\\$read_length\\\\\\\"\\ \\\\\\\\\\\\n\\ \\ \\ \\ --total_coverage\\ \\\\\\\"\\$coverage\\\\\\\"\\ \\\\\\\\\\\\n\\ \\ \\ \\ --mean_fragment_size\\ \\\\\\\"\\$mean_fragment_size\\\\\\\"\\ \\\\\\\\\\\\n\\ \\ \\ \\ --sd_fragment_size\\ \\\\\\\"\\$stddev_fragment_size\\\\\\\"\\ \\\\\\\\\\\\n\\ \\ \\ \\ \\$sampling_opts\\ \\$nonsampling_opts\\ \\$varsim_other_opts\\ \\\\\\\\\\\\n\\ \\ \\ \\ --simulator\\ art\\ \\\\\\\\\\\\n\\ \\ \\ \\ --simulator_executable\\ /opt/art/art_illumina\\ \\\\\\\\\\\\n\\ \\ \\ \\ --art_options\\ \\\\\\\"--seqSys\\ \\$art_ss\\\\\\\"\\ \\\\\\\\\\\\n\\ \\ \\ \\ --id\\ simulated_reads\\ \\\\\\\\\\\\n\\ \\ \\ \\ --disable_rand_dgv\\ \\\\\\\\\\\\n\\ \\ \\ \\ --vc_num_snp\\ \\\\\\\"\\$number_of_snvs\\\\\\\"\\ \\\\\\\\\\\\n\\ \\ \\ \\ --out_dir\\ varsim_out\\ --log_dir\\ \\\\\\\"\\$output_name\\\\\\\"_log\\\\n\\ \\ \\ \\ \\\\ncat\\ varsim_out/\\*1.fq.gz\\ \\\\u003e\\ \\\\\\\"\\$output_name\\\\\\\"_1.fastq.gz\\\\nemit\\ simulated_reads1\\ \\\\\\\"\\$output_name\\\\\\\"_1.fastq.gz\\\\nrm\\ -f\\ \\\\\\\"\\$output_name\\\\\\\"_1.fastq.gz\\\\n\\\\ncat\\ varsim_out/\\*2.fq.gz\\ \\\\u003e\\ \\\\\\\"\\$output_name\\\\\\\"_2.fastq.gz\\\\nemit\\ simulated_reads2\\ \\\\\\\"\\$output_name\\\\\\\"_2.fastq.gz\\\\nrm\\ -f\\ \\\\\\\"\\$output_name\\\\\\\"_2.fastq.gz\\\\n\\\\njava\\ -jar\\ /usr/bin/picard.jar\\ SortVcf\\ INPUT\\=varsim_out/simulated_reads.truth.vcf\\ OUTPUT\\=\\\\\\\"\\$output_name\\\\\\\".truth.vcf\\ SEQUENCE_DICTIONARY\\=\\$refname.dict\\ VALIDATION_STRINGENCY\\=LENIENT\\\\nbgzip\\ \\\\\\\"\\$output_name\\\\\\\".truth.vcf\\\\nemit\\ truth_vcfgz\\ \\\\\\\"\\$output_name\\\\\\\".truth.vcf.gz\\\\n\\\\ntabix\\ -p\\ vcf\\ \\\\\\\"\\$output_name\\\\\\\".truth.vcf.gz\\\\nemit\\ truth_tbi\\ \\\\\\\"\\$output_name\\\\\\\".truth.vcf.gz.tbi\\\\n\\\\ntar\\ -cv\\ \\\\\\\"\\$output_name\\\\\\\"_log\\ \\|\\ gzip\\ \\\\u003e\\ \\\\\\\"\\$output_name\\\\\\\"_log.tar.gz\\\\nemit\\ log_targz\\ \\\\\\\"\\$output_name\\\\\\\"_log.tar.gz\\\"\\} | python -c 'import sys,json; print json.load(sys.stdin)[\"code\"]' \u003e /script.sh"]

# Create directory /work and set it to $HOME and CWD
RUN mkdir -p /work
ENV HOME="/work"
WORKDIR /work

# Set entry point to container
ENTRYPOINT ["/usr/bin/run"]

VOLUME /data
VOLUME /work