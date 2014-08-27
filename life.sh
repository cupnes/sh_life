#!/bin/bash
datafile=input.dat

mapfile=tmp_map.dat
if [ ! -f "$mapfile" ]; then
	cp "$datafile" "$mapfile"
fi

awk '
	BEGIN{
		FS = " ";
		OFS = " ";
		max_nf = 0;
		max_nr = 0;
	}
	{
		if (max_nf < NF) max_nf = NF;
		max_nr = NR;
		for (i = 1; i <= NF; i++) map[i, NR] = $i;
	}
	END{
		for (i = 1; i <= max_nr; i++) {
			for (j = 1; j <= max_nf; j++) {
				life_num = 0;
				for (t_i = i - 1; t_i <= i + 1; t_i++) {
					if (t_i < 1 || max_nr < t_i) continue;
					for (t_j = j - 1; t_j <= j + 1; t_j++) {
						if (t_j < 1 || max_nf < t_j) continue;
						if (t_i == i && t_j == j) continue;
						if (map[t_j, t_i] == 1) life_num++;
					}
				}

				if (map[j, i] == 0 && life_num == 3) {
					printf "1 ";
				} else if (map[j, i] == 1 && (life_num <= 1 || 4 <= life_num)) {
					printf "0 ";
				} else {
					printf "%d ", map[j, i];
				}
			}
			print "";
		}
	}' "$mapfile" > "tmp.dat"
cp "tmp.dat" "$mapfile"
rm -f "tmp.dat"
clear
awk '
	BEGIN{
		FS = " ";
		OFS = " ";
	}
	{
		for (i = 1; i <= NF; i++) {
			if ($i == 0) printf " ";
			else printf "*";
		}
		print "";
	}' "$mapfile"

