#!/usr/bin/env bash
### created 02.01.2020
### Silvio Siefke <siefke@mail.ru>
### Simple Public License (SimPL)

path="$1"

### grep the data we need for working with it
# filenames
for files in "$path"/*.md; do
  grep -r "geo:" | sed 's/.md:/.md /g' | awk '{print $1}' > /tmp/filename.txt;
done

# geo
for files in "$path"/*.md; do
  grep -r "geo:" | sed 's/.md:/.md /g' | awk '{print $3}' > /tmp/geo.txt;
done

# read in the filenames and geo tags in an array
readarray -t post < /tmp/filename.txt
readarray -t geo < /tmp/geo.txt

# rm draft temporary
for i in "${post[@]}"; do
    sed -i '/draft/d' "$i"
done

# append the geo tag
for i in "${!post[@]}"; do
    while IFS= read -r line;
        do echo "$line" >> tempfile;
        [ "${line:0:3}" = "tag" ] && echo "geo: ${geo[i]}" >> tempfile;
    done < "${post[i]}";
mv -f tempfile "${post[i]}";
done

# append again the draft
for i in "${post[@]}"; do
    sed -i '/geo/a draft: false' "$i"
done
