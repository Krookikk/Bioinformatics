# Makefile — минимальный пайплайн

REF = data/GCF_000005845.2_ASM584v2_genomic.fna
READS = data/SRR32912200.fastq.gz
SAM = results/SRR32912200.sam
BAM = results/SRR32912200.bam
SORTED_BAM = results/SRR32912200.sorted.bam
SORTED_BAI = results/SRR32912200.sorted.bam.bai
MMI = results/ecoli_ref.mmi
FLAGSTAT = results/flagstat.txt
CHECK = results/check.txt

# Цель по умолчанию
all: $(CHECK)

# Индексация референса
$(MMI): $(REF)
	minimap2 -d $(MMI) $(REF)

# Картирование
$(SAM): $(READS) $(MMI)
	minimap2 -ax map-ont $(MMI) $(READS) > $(SAM)

# SAM -> BAM
$(BAM): $(SAM)
	samtools view -S -b $(SAM) > $(BAM)

# Сортировка BAM
$(SORTED_BAM): $(BAM)
	samtools sort $(BAM) -o $(SORTED_BAM)

# Индексация BAM
$(SORTED_BAI): $(SORTED_BAM)
	samtools index $(SORTED_BAM)

# Статистика
$(FLAGSTAT): $(SORTED_BAM)
	samtools flagstat $(SORTED_BAM) > $(FLAGSTAT)

# Разбор результатов
$(CHECK): $(FLAGSTAT) scripts/parse_flagstat.sh
	bash scripts/parse_flagstat.sh $(FLAGSTAT) > $(CHECK)

# Очистка
clean:
	rm -f $(SAM) $(BAM) $(SORTED_BAM) $(SORTED_BAI) $(FLAGSTAT) $(CHECK)
