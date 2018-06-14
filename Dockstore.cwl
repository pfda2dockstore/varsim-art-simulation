baseCommand: []
class: CommandLineTool
cwlVersion: v1.0
id: varsim-art-simulation
inputs:
  coverage:
    default: 10
    doc: Fold level coverage to simulate
    inputBinding:
      position: 8
      prefix: --coverage
    type: double?
  mean_fragment_size:
    default: 500
    doc: The mean size of the simulated sequenced DNA fragments. That is, this is
      the distance between the outer edges of each read.
    inputBinding:
      position: 4
      prefix: --mean_fragment_size
    type: long?
  nonsampling_vcf:
    doc: Variants in addition to sampling VCF
    inputBinding:
      position: 10
      prefix: --nonsampling_vcf
    type: File?
  number_of_snvs:
    default: 100
    doc: The number of SNVs to sample sampling VCF
    inputBinding:
      position: 1
      prefix: --number_of_snvs
    type: long
  output_name:
    doc: A name after which the output files will be called (name_1.fastq.gz, name.vcf.gz,
      etc.)
    inputBinding:
      position: 6
      prefix: --output_name
    type: string
  read_length:
    default: 150
    doc: The length of each simulated read.
    inputBinding:
      position: 2
      prefix: --read_length
    type: long?
  refname:
    default: grch37
    doc: ''
    inputBinding:
      position: 7
      prefix: --refname
    type: string?
  sampling_vcf:
    doc: VCF to sample variants from.  Example files could be dbSNP, clinvar.
    inputBinding:
      position: 9
      prefix: --sampling_vcf
    type: File?
  sequencing_system:
    default: HiSeq 2500
    doc: The sequencing system to simulate.
    inputBinding:
      position: 3
      prefix: --sequencing_system
    type: string?
  stddev_fragment_size:
    default: 50
    doc: The standard deviation of simulated DNA fragment sizes.
    inputBinding:
      position: 5
      prefix: --stddev_fragment_size
    type: long?
  varsim_other_opts:
    doc: Other options for varsim.py can be put here
    inputBinding:
      position: 11
      prefix: --varsim_other_opts
    type: string?
label: 'VarSim: Simulation'
outputs:
  log_targz:
    doc: The log files from VarSim
    outputBinding:
      glob: log_targz/*
    type: File
  simulated_reads1:
    doc: The gzipped FASTQ containing the first mates.
    outputBinding:
      glob: simulated_reads1/*
    type: File
  simulated_reads2:
    doc: The gzipped FASTQ containing the second mates.
    outputBinding:
      glob: simulated_reads2/*
    type: File
  truth_tbi:
    doc: The associated TBI file for the simulated variants.
    outputBinding:
      glob: truth_tbi/*
    type: File
  truth_vcfgz:
    doc: A bgzipped VCF file containing the simulated variants.
    outputBinding:
      glob: truth_vcfgz/*
    type: File
requirements:
- class: DockerRequirement
  dockerOutputDirectory: /data/out
  dockerPull: pfda2dockstore/varsim-art-simulation:16
s:author:
  class: s:Person
  s:name: Marghoob Mohiyuddin
