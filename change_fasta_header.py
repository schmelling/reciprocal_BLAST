import sys
import glob
from Bio import SeqIO

def change_fasta(path):
for file in glob.glob(path+'/*.faa'):
    new_fasta = open(file[:-1]+'sta', 'w')
    for seq_record in SeqIO.parse(file, 'fasta'):
        ID = file.split('/')[-1].split('_',2)[0]+'_'+file.split('_',2)[1]
        new_fasta.write('>'+seq_record.description+' '+ID+'\n')
        new_fasta.write(str(seq_record.seq)+'\n')
    new_fasta.close()


if __name__ == "__main__":
    path = sys.argv[1]

    complementary_seq(path)
