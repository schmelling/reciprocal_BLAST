wget ftp://ftp.ncbi.nih.gov/genomes/refseq/assembly_summary_refseq.txt

awk -F '\t' '{if($12=="Complete Genome") print $20}' assembly_summary_refseq.txt > assembly_summary_complete_genomes.txt
awk -F '\t' '{if($12=="Chromosome") print $20}' assembly_summary_refseq.txt > assembly_summary_chromosome.txt

mkdir RefSeqCompleteGenomes
mkdir RefSeqCompleteReports
mkdir RefSeqChromosomeGenomes
mkdir RefSeqChromosomeReports
mkdir db

for next in $(cat assembly_summary_complete_genomes.txt);
do
wget -P RefSeqCompleteGenomes "$next"/*protein.faa.gz;
wget -P RefSeqCompleteReports "$next"/*assembly_report.txt;
done

for next in $(cat assembly_summary_chromosome.txt);
do
wget -P RefSeqChromosomeGenomes "$next"/*protein.faa.gz;
wget -P RefSeqChromosomeReports "$next"/*assembly_report.txt;
done

gunzip RefSeqCompleteGenomes/*.gz
gunzip RefSeqChromosomeGenomes/*.gz

python change_fasta_header.py RefSeqCompleteGenomes
python change_fasta_header.py RefSeqChromosomeGenomes

cat RefSeqCompleteGenomes/*.fasta > db/all_complete_genomes.fasta
cat RefSeqChromosomeGenomes/*.fasta > db/all_chromosomes.fasta

cat db/all_complete_genome.fasta db/all_chromosome.fasta > db/all_genomes.fasta
