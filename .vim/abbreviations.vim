:iabbrev @@ kiefl.evan@gmail.com
:iabbrev dsdsds https://github.com/merenlab/anvio/issues/1282
:iabbrev ppp import ipdb; ipdb.set_trace()
:iabbrev ooo import pdb; pdb.set_trace()
:iabbrev iii import pytest; pytest.set_trace()
:iabbrev fm FIXME

:iabbrev commandi 
\<div class="extra-info" style="{{ command_style }}" markdown="1">
\<CR><span class="extra-info-header">Command #X</span>
\<CR>```<esc>lc$bash
\<CR><commandhere>
\<CR>```<esc>lc$
\<CR>‣ **Time:** Minimal  
\<CR>‣ **Storage:** Minimal  
\<CR>‣ **Memory:** Minimal  
\<CR></div>

:iabbrev stepi 
\<CR><div class="extra-info" markdown="1">
\<CR><span class="extra-info-header">Step X Info</span>
\<CR>‣ **Prerequisite steps:** None  
\<CR>‣ **Checkpoint datapack:** None  
\<CR></div>

:iabbrev showi 
\<CR><details markdown="1"><summary>Show/Hide Script</summary>
\<CR></details>

:iabbrev anvi-analyze-syntenyi {% include PROGRAM name="anvi-analyze-synteny" %}
:iabbrev anvi-cluster-contigsi {% include PROGRAM name="anvi-cluster-contigs" %}
:iabbrev anvi-compute-completenessi {% include PROGRAM name="anvi-compute-completeness" %}
:iabbrev anvi-compute-functional-enrichment-across-genomesi {% include PROGRAM name="anvi-compute-functional-enrichment-across-genomes" %}
:iabbrev anvi-compute-functional-enrichment-in-pani {% include PROGRAM name="anvi-compute-functional-enrichment-in-pan" %}
:iabbrev anvi-compute-functional-enrichmenti {% include PROGRAM name="anvi-compute-functional-enrichment" %}
:iabbrev anvi-compute-gene-cluster-homogeneityi {% include PROGRAM name="anvi-compute-gene-cluster-homogeneity" %}
:iabbrev anvi-compute-genome-similarityi {% include PROGRAM name="anvi-compute-genome-similarity" %}
:iabbrev anvi-compute-metabolic-enrichmenti {% include PROGRAM name="anvi-compute-metabolic-enrichment" %}
:iabbrev anvi-db-infoi {% include PROGRAM name="anvi-db-info" %}
:iabbrev anvi-delete-collectioni {% include PROGRAM name="anvi-delete-collection" %}
:iabbrev anvi-delete-hmmsi {% include PROGRAM name="anvi-delete-hmms" %}
:iabbrev anvi-delete-misc-datai {% include PROGRAM name="anvi-delete-misc-data" %}
:iabbrev anvi-delete-statei {% include PROGRAM name="anvi-delete-state" %}
:iabbrev anvi-dereplicate-genomesi {% include PROGRAM name="anvi-dereplicate-genomes" %}
:iabbrev anvi-display-contigs-statsi {% include PROGRAM name="anvi-display-contigs-stats" %}
:iabbrev anvi-display-functionsi {% include PROGRAM name="anvi-display-functions" %}
:iabbrev anvi-display-metabolismi {% include PROGRAM name="anvi-display-metabolism" %}
:iabbrev anvi-display-pani {% include PROGRAM name="anvi-display-pan" %}
:iabbrev anvi-display-structurei {% include PROGRAM name="anvi-display-structure" %}
:iabbrev anvi-estimate-genome-completenessi {% include PROGRAM name="anvi-estimate-genome-completeness" %}
:iabbrev anvi-estimate-metabolismi {% include PROGRAM name="anvi-estimate-metabolism" %}
:iabbrev anvi-estimate-scg-taxonomyi {% include PROGRAM name="anvi-estimate-scg-taxonomy" %}
:iabbrev anvi-estimate-trna-taxonomyi {% include PROGRAM name="anvi-estimate-trna-taxonomy" %}
:iabbrev anvi-experimental-organizationi {% include PROGRAM name="anvi-experimental-organization" %}
:iabbrev anvi-export-collectioni {% include PROGRAM name="anvi-export-collection" %}
:iabbrev anvi-export-contigsi {% include PROGRAM name="anvi-export-contigs" %}
:iabbrev anvi-export-functionsi {% include PROGRAM name="anvi-export-functions" %}
:iabbrev anvi-export-gene-callsi {% include PROGRAM name="anvi-export-gene-calls" %}
:iabbrev anvi-export-gene-coverage-and-detectioni {% include PROGRAM name="anvi-export-gene-coverage-and-detection" %}
:iabbrev anvi-export-items-orderi {% include PROGRAM name="anvi-export-items-order" %}
:iabbrev anvi-export-locusi {% include PROGRAM name="anvi-export-locus" %}
:iabbrev anvi-export-misc-datai {% include PROGRAM name="anvi-export-misc-data" %}
:iabbrev anvi-export-splits-and-coveragesi {% include PROGRAM name="anvi-export-splits-and-coverages" %}
:iabbrev anvi-export-splits-taxonomyi {% include PROGRAM name="anvi-export-splits-taxonomy" %}
:iabbrev anvi-export-statei {% include PROGRAM name="anvi-export-state" %}
:iabbrev anvi-export-structuresi {% include PROGRAM name="anvi-export-structures" %}
:iabbrev anvi-gen-contigs-databasei {% include PROGRAM name="anvi-gen-contigs-database" %}
:iabbrev anvi-gen-fixation-index-matrixi {% include PROGRAM name="anvi-gen-fixation-index-matrix" %}
:iabbrev anvi-gen-gene-consensus-sequencesi {% include PROGRAM name="anvi-gen-gene-consensus-sequences" %}
:iabbrev anvi-gen-gene-level-stats-databasesi {% include PROGRAM name="anvi-gen-gene-level-stats-databases" %}
:iabbrev anvi-gen-genomes-storagei {% include PROGRAM name="anvi-gen-genomes-storage" %}
:iabbrev anvi-gen-phylogenomic-treei {% include PROGRAM name="anvi-gen-phylogenomic-tree" %}
:iabbrev anvi-gen-structure-databasei {% include PROGRAM name="anvi-gen-structure-database" %}
:iabbrev anvi-gen-variability-profilei {% include PROGRAM name="anvi-gen-variability-profile" %}
:iabbrev anvi-get-aa-countsi {% include PROGRAM name="anvi-get-aa-counts" %}
:iabbrev anvi-get-codon-frequenciesi {% include PROGRAM name="anvi-get-codon-frequencies" %}
:iabbrev anvi-get-pn-ps-ratioi {% include PROGRAM name="anvi-get-pn-ps-ratio" %}
:iabbrev anvi-get-sequences-for-gene-callsi {% include PROGRAM name="anvi-get-sequences-for-gene-calls" %}
:iabbrev anvi-get-sequences-for-gene-clustersi {% include PROGRAM name="anvi-get-sequences-for-gene-clusters" %}
:iabbrev anvi-get-sequences-for-hmm-hitsi {% include PROGRAM name="anvi-get-sequences-for-hmm-hits" %}
:iabbrev anvi-get-short-reads-from-bami {% include PROGRAM name="anvi-get-short-reads-from-bam" %}
:iabbrev anvi-get-short-reads-mapping-to-a-genei {% include PROGRAM name="anvi-get-short-reads-mapping-to-a-gene" %}
:iabbrev anvi-get-split-coveragesi {% include PROGRAM name="anvi-get-split-coverages" %}
:iabbrev anvi-get-tlen-dist-from-bami {% include PROGRAM name="anvi-get-tlen-dist-from-bam" %}
:iabbrev anvi-import-collectioni {% include PROGRAM name="anvi-import-collection" %}
:iabbrev anvi-import-functionsi {% include PROGRAM name="anvi-import-functions" %}
:iabbrev anvi-import-items-orderi {% include PROGRAM name="anvi-import-items-order" %}
:iabbrev anvi-import-misc-datai {% include PROGRAM name="anvi-import-misc-data" %}
:iabbrev anvi-import-statei {% include PROGRAM name="anvi-import-state" %}
:iabbrev anvi-import-taxonomy-for-genesi {% include PROGRAM name="anvi-import-taxonomy-for-genes" %}
:iabbrev anvi-import-taxonomy-for-layersi {% include PROGRAM name="anvi-import-taxonomy-for-layers" %}
:iabbrev anvi-init-bami {% include PROGRAM name="anvi-init-bam" %}
:iabbrev anvi-inspecti {% include PROGRAM name="anvi-inspect" %}
:iabbrev anvi-interactivei {% include PROGRAM name="anvi-interactive" %}
:iabbrev anvi-matrix-to-newicki {% include PROGRAM name="anvi-matrix-to-newick" %}
:iabbrev anvi-merge-binsi {% include PROGRAM name="anvi-merge-bins" %}
:iabbrev anvi-merge-trnaseqi {% include PROGRAM name="anvi-merge-trnaseq" %}
:iabbrev anvi-mergei {% include PROGRAM name="anvi-merge" %}
:iabbrev anvi-meta-pan-genomei {% include PROGRAM name="anvi-meta-pan-genome" %}
:iabbrev anvi-migratei {% include PROGRAM name="anvi-migrate" %}
:iabbrev anvi-oligotype-linkmersi {% include PROGRAM name="anvi-oligotype-linkmers" %}
:iabbrev anvi-pan-genomei {% include PROGRAM name="anvi-pan-genome" %}
:iabbrev anvi-plot-trnaseqi {% include PROGRAM name="anvi-plot-trnaseq" %}
:iabbrev anvi-profile-blitzi {% include PROGRAM name="anvi-profile-blitz" %}
:iabbrev anvi-profilei {% include PROGRAM name="anvi-profile" %}
:iabbrev anvi-refinei {% include PROGRAM name="anvi-refine" %}
:iabbrev anvi-rename-binsi {% include PROGRAM name="anvi-rename-bins" %}
:iabbrev anvi-report-linkmersi {% include PROGRAM name="anvi-report-linkmers" %}
:iabbrev anvi-run-hmmsi {% include PROGRAM name="anvi-run-hmms" %}
:iabbrev anvi-run-interacdomei {% include PROGRAM name="anvi-run-interacdome" %}
:iabbrev anvi-run-kegg-kofamsi {% include PROGRAM name="anvi-run-kegg-kofams" %}
:iabbrev anvi-run-ncbi-cogsi {% include PROGRAM name="anvi-run-ncbi-cogs" %}
:iabbrev anvi-run-pfamsi {% include PROGRAM name="anvi-run-pfams" %}
:iabbrev anvi-run-scg-taxonomyi {% include PROGRAM name="anvi-run-scg-taxonomy" %}
:iabbrev anvi-run-trna-taxonomyi {% include PROGRAM name="anvi-run-trna-taxonomy" %}
:iabbrev anvi-run-workflowi {% include PROGRAM name="anvi-run-workflow" %}
:iabbrev anvi-scan-trnasi {% include PROGRAM name="anvi-scan-trnas" %}
:iabbrev anvi-script-add-default-collectioni {% include PROGRAM name="anvi-script-add-default-collection" %}
:iabbrev anvi-script-checkm-tree-to-interactivei {% include PROGRAM name="anvi-script-checkm-tree-to-interactive" %}
:iabbrev anvi-script-compute-ani-for-fastai {% include PROGRAM name="anvi-script-compute-ani-for-fasta" %}
:iabbrev anvi-script-filter-fasta-by-blasti {% include PROGRAM name="anvi-script-filter-fasta-by-blast" %}
:iabbrev anvi-script-filter-hmm-hits-tablei {% include PROGRAM name="anvi-script-filter-hmm-hits-table" %}
:iabbrev anvi-script-fix-homopolymer-indelsi {% include PROGRAM name="anvi-script-fix-homopolymer-indels" %}
:iabbrev anvi-script-gen-distribution-of-genes-in-a-bini {% include PROGRAM name="anvi-script-gen-distribution-of-genes-in-a-bin" %}
:iabbrev anvi-script-gen-genomes-filei {% include PROGRAM name="anvi-script-gen-genomes-file" %}
:iabbrev anvi-script-gen-hmm-hits-matrix-across-genomesi {% include PROGRAM name="anvi-script-gen-hmm-hits-matrix-across-genomes" %}
:iabbrev anvi-script-gen-pseudo-paired-reads-from-fastqi {% include PROGRAM name="anvi-script-gen-pseudo-paired-reads-from-fastq" %}
:iabbrev anvi-script-gen-short-readsi {% include PROGRAM name="anvi-script-gen-short-reads" %}
:iabbrev anvi-script-gen_stats_for_single_copy_genesi {% include PROGRAM name="anvi-script-gen_stats_for_single_copy_genes" %}
:iabbrev anvi-script-get-coverage-from-bami {% include PROGRAM name="anvi-script-get-coverage-from-bam" %}
:iabbrev anvi-script-get-hmm-hits-per-gene-calli {% include PROGRAM name="anvi-script-get-hmm-hits-per-gene-call" %}
:iabbrev anvi-script-get-primer-matchesi {% include PROGRAM name="anvi-script-get-primer-matches" %}
:iabbrev anvi-script-merge-collectionsi {% include PROGRAM name="anvi-script-merge-collections" %}
:iabbrev anvi-script-process-genbank-metadatai {% include PROGRAM name="anvi-script-process-genbank-metadata" %}
:iabbrev anvi-script-process-genbanki {% include PROGRAM name="anvi-script-process-genbank" %}
:iabbrev anvi-script-reformat-fastai {% include PROGRAM name="anvi-script-reformat-fasta" %}
:iabbrev anvi-script-snvs-to-interactivei {% include PROGRAM name="anvi-script-snvs-to-interactive" %}
:iabbrev anvi-script-transpose-matrixi {% include PROGRAM name="anvi-script-transpose-matrix" %}
:iabbrev anvi-script-variability-to-vcfi {% include PROGRAM name="anvi-script-variability-to-vcf" %}
:iabbrev anvi-search-functionsi {% include PROGRAM name="anvi-search-functions" %}
:iabbrev anvi-search-palindromesi {% include PROGRAM name="anvi-search-palindromes" %}
:iabbrev anvi-search-sequence-motifsi {% include PROGRAM name="anvi-search-sequence-motifs" %}
:iabbrev anvi-setup-interacdomei {% include PROGRAM name="anvi-setup-interacdome" %}
:iabbrev anvi-setup-kegg-kofamsi {% include PROGRAM name="anvi-setup-kegg-kofams" %}
:iabbrev anvi-setup-ncbi-cogsi {% include PROGRAM name="anvi-setup-ncbi-cogs" %}
:iabbrev anvi-setup-pdb-databasei {% include PROGRAM name="anvi-setup-pdb-database" %}
:iabbrev anvi-setup-pfamsi {% include PROGRAM name="anvi-setup-pfams" %}
:iabbrev anvi-setup-scg-taxonomyi {% include PROGRAM name="anvi-setup-scg-taxonomy" %}
:iabbrev anvi-setup-trna-taxonomyi {% include PROGRAM name="anvi-setup-trna-taxonomy" %}
:iabbrev anvi-show-collections-and-binsi {% include PROGRAM name="anvi-show-collections-and-bins" %}
:iabbrev anvi-show-misc-datai {% include PROGRAM name="anvi-show-misc-data" %}
:iabbrev anvi-spliti {% include PROGRAM name="anvi-split" %}
:iabbrev anvi-summarize-blitzi {% include PROGRAM name="anvi-summarize-blitz" %}
:iabbrev anvi-summarizei {% include PROGRAM name="anvi-summarize" %}
:iabbrev anvi-summary-blitzi {% include PROGRAM name="anvi-summary-blitz" %}
:iabbrev anvi-tabulate-trnaseqi {% include PROGRAM name="anvi-tabulate-trnaseq" %}
:iabbrev anvi-trnaseqi {% include PROGRAM name="anvi-trnaseq" %}
:iabbrev anvi-update-db-descriptioni {% include PROGRAM name="anvi-update-db-description" %}
:iabbrev anvi-update-structure-databasei {% include PROGRAM name="anvi-update-structure-database" %}

:iabbrev aa-frequencies-txti {% include ARTIFACT name="aa-frequencies-txt" %}
:iabbrev augustus-gene-callsi {% include ARTIFACT name="augustus-gene-calls" %}
:iabbrev bam-filei {% include ARTIFACT name="bam-file" %}
:iabbrev bam-stats-txti {% include ARTIFACT name="bam-stats-txt" %}
:iabbrev bini {% include ARTIFACT name="bin" %}
:iabbrev binding-frequencies-txti {% include ARTIFACT name="binding-frequencies-txt" %}
:iabbrev blast-tablei {% include ARTIFACT name="blast-table" %}
:iabbrev codon-frequencies-txti {% include ARTIFACT name="codon-frequencies-txt" %}
:iabbrev cogs-datai {% include ARTIFACT name="cogs-data" %}
:iabbrev collection-txti {% include ARTIFACT name="collection-txt" %}
:iabbrev collectioni {% include ARTIFACT name="collection" %}
:iabbrev completioni {% include ARTIFACT name="completion" %}
:iabbrev concatenated-gene-alignment-fastai {% include ARTIFACT name="concatenated-gene-alignment-fasta" %}
:iabbrev configuration-inii {% include ARTIFACT name="configuration-ini" %}
:iabbrev contig-inspectioni {% include ARTIFACT name="contig-inspection" %}
:iabbrev contigs-dbi {% include ARTIFACT name="contigs-db" %}
:iabbrev contigs-fastai {% include ARTIFACT name="contigs-fasta" %}
:iabbrev contigs-statsi {% include ARTIFACT name="contigs-stats" %}
:iabbrev coverages-txti {% include ARTIFACT name="coverages-txt" %}
:iabbrev dendrogrami {% include ARTIFACT name="dendrogram" %}
:iabbrev detection-txti {% include ARTIFACT name="detection-txt" %}
:iabbrev dna-sequencei {% include ARTIFACT name="dna-sequence" %}
:iabbrev external-gene-callsi {% include ARTIFACT name="external-gene-calls" %}
:iabbrev external-genomesi {% include ARTIFACT name="external-genomes" %}
:iabbrev external-structuresi {% include ARTIFACT name="external-structures" %}
:iabbrev fasta-txti {% include ARTIFACT name="fasta-txt" %}
:iabbrev fastai {% include ARTIFACT name="fasta" %}
:iabbrev fixation-index-matrixi {% include ARTIFACT name="fixation-index-matrix" %}
:iabbrev functional-enrichment-txti {% include ARTIFACT name="functional-enrichment-txt" %}
:iabbrev functions-txti {% include ARTIFACT name="functions-txt" %}
:iabbrev functionsi {% include ARTIFACT name="functions" %}
:iabbrev genbank-filei {% include ARTIFACT name="genbank-file" %}
:iabbrev gene-calls-txti {% include ARTIFACT name="gene-calls-txt" %}
:iabbrev gene-cluster-inspectioni {% include ARTIFACT name="gene-cluster-inspection" %}
:iabbrev gene-taxonomy-txti {% include ARTIFACT name="gene-taxonomy-txt" %}
:iabbrev gene-taxonomyi {% include ARTIFACT name="gene-taxonomy" %}
:iabbrev genes-dbi {% include ARTIFACT name="genes-db" %}
:iabbrev genes-fastai {% include ARTIFACT name="genes-fasta" %}
:iabbrev genes-statsi {% include ARTIFACT name="genes-stats" %}
:iabbrev genome-similarityi {% include ARTIFACT name="genome-similarity" %}
:iabbrev genome-taxonomy-txti {% include ARTIFACT name="genome-taxonomy-txt" %}
:iabbrev genome-taxonomyi {% include ARTIFACT name="genome-taxonomy" %}
:iabbrev genomes-storage-dbi {% include ARTIFACT name="genomes-storage-db" %}
:iabbrev groups-txti {% include ARTIFACT name="groups-txt" %}
:iabbrev hmm-hits-matrix-txti {% include ARTIFACT name="hmm-hits-matrix-txt" %}
:iabbrev hmm-hitsi {% include ARTIFACT name="hmm-hits" %}
:iabbrev hmm-sourcei {% include ARTIFACT name="hmm-source" %}
:iabbrev interacdome-datai {% include ARTIFACT name="interacdome-data" %}
:iabbrev interactivei {% include ARTIFACT name="interactive" %}
:iabbrev internal-genomesi {% include ARTIFACT name="internal-genomes" %}
:iabbrev kegg-datai {% include ARTIFACT name="kegg-data" %}
:iabbrev kegg-functionsi {% include ARTIFACT name="kegg-functions" %}
:iabbrev kegg-metabolismi {% include ARTIFACT name="kegg-metabolism" %}
:iabbrev layer-taxonomy-txti {% include ARTIFACT name="layer-taxonomy-txt" %}
:iabbrev layer-taxonomyi {% include ARTIFACT name="layer-taxonomy" %}
:iabbrev linkmers-txti {% include ARTIFACT name="linkmers-txt" %}
:iabbrev locus-fastai {% include ARTIFACT name="locus-fasta" %}
:iabbrev metagenomesi {% include ARTIFACT name="metagenomes" %}
:iabbrev metapangenomei {% include ARTIFACT name="metapangenome" %}
:iabbrev misc-data-amino-acids-txti {% include ARTIFACT name="misc-data-amino-acids-txt" %}
:iabbrev misc-data-amino-acidsi {% include ARTIFACT name="misc-data-amino-acids" %}
:iabbrev misc-data-items-order-txti {% include ARTIFACT name="misc-data-items-order-txt" %}
:iabbrev misc-data-items-orderi {% include ARTIFACT name="misc-data-items-order" %}
:iabbrev misc-data-items-txti {% include ARTIFACT name="misc-data-items-txt" %}
:iabbrev misc-data-itemsi {% include ARTIFACT name="misc-data-items" %}
:iabbrev misc-data-layer-orders-txti {% include ARTIFACT name="misc-data-layer-orders-txt" %}
:iabbrev misc-data-layer-ordersi {% include ARTIFACT name="misc-data-layer-orders" %}
:iabbrev misc-data-layers-txti {% include ARTIFACT name="misc-data-layers-txt" %}
:iabbrev misc-data-layersi {% include ARTIFACT name="misc-data-layers" %}
:iabbrev misc-data-nucleotides-txti {% include ARTIFACT name="misc-data-nucleotides-txt" %}
:iabbrev misc-data-nucleotidesi {% include ARTIFACT name="misc-data-nucleotides" %}
:iabbrev modifications-txti {% include ARTIFACT name="modifications-txt" %}
:iabbrev modules-dbi {% include ARTIFACT name="modules-db" %}
:iabbrev ngramsi {% include ARTIFACT name="ngrams" %}
:iabbrev oligotypesi {% include ARTIFACT name="oligotypes" %}
:iabbrev palindromes-txti {% include ARTIFACT name="palindromes-txt" %}
:iabbrev pan-dbi {% include ARTIFACT name="pan-db" %}
:iabbrev pdb-dbi {% include ARTIFACT name="pdb-db" %}
:iabbrev pfams-datai {% include ARTIFACT name="pfams-data" %}
:iabbrev phylogenyi {% include ARTIFACT name="phylogeny" %}
:iabbrev pn-ps-datai {% include ARTIFACT name="pn-ps-data" %}
:iabbrev profile-dbi {% include ARTIFACT name="profile-db" %}
:iabbrev protein-structure-txti {% include ARTIFACT name="protein-structure-txt" %}
:iabbrev quick-summaryi {% include ARTIFACT name="quick-summary" %}
:iabbrev raw-bam-filei {% include ARTIFACT name="raw-bam-file" %}
:iabbrev samples-txti {% include ARTIFACT name="samples-txt" %}
:iabbrev scgs-taxonomy-dbi {% include ARTIFACT name="scgs-taxonomy-db" %}
:iabbrev scgs-taxonomyi {% include ARTIFACT name="scgs-taxonomy" %}
:iabbrev seeds-non-specific-txti {% include ARTIFACT name="seeds-non-specific-txt" %}
:iabbrev seeds-specific-txti {% include ARTIFACT name="seeds-specific-txt" %}
:iabbrev short-reads-fastai {% include ARTIFACT name="short-reads-fasta" %}
:iabbrev single-profile-dbi {% include ARTIFACT name="single-profile-db" %}
:iabbrev split-binsi {% include ARTIFACT name="split-bins" %}
:iabbrev splits-taxonomy-txti {% include ARTIFACT name="splits-taxonomy-txt" %}
:iabbrev splits-txti {% include ARTIFACT name="splits-txt" %}
:iabbrev state-jsoni {% include ARTIFACT name="state-json" %}
:iabbrev statei {% include ARTIFACT name="state" %}
:iabbrev structure-dbi {% include ARTIFACT name="structure-db" %}
:iabbrev summaryi {% include ARTIFACT name="summary" %}
:iabbrev svgi {% include ARTIFACT name="svg" %}
:iabbrev trna-taxonomy-dbi {% include ARTIFACT name="trna-taxonomy-db" %}
:iabbrev trna-taxonomyi {% include ARTIFACT name="trna-taxonomy" %}
:iabbrev trnaseq-contigs-dbi {% include ARTIFACT name="trnaseq-contigs-db" %}
:iabbrev trnaseq-dbi {% include ARTIFACT name="trnaseq-db" %}
:iabbrev trnaseq-fastai {% include ARTIFACT name="trnaseq-fasta" %}
:iabbrev trnaseq-profile-dbi {% include ARTIFACT name="trnaseq-profile-db" %}
:iabbrev trnaseq-workflowi {% include ARTIFACT name="trnaseq-workflow" %}
:iabbrev variability-profile-txti {% include ARTIFACT name="variability-profile-txt" %}
:iabbrev variability-profilei {% include ARTIFACT name="variability-profile" %}
:iabbrev vcfi {% include ARTIFACT name="vcf" %}
:iabbrev view-datai {% include ARTIFACT name="view-data" %}
:iabbrev workflow-configi {% include ARTIFACT name="workflow-config" %}
