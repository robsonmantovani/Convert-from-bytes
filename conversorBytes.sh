#!/bin/sh
#Script para receber bytes como parametro e os converter para MiB, GiB, TiB, etc
# Fonte: https://unix.stackexchange.com/questions/44040/a-standard-tool-to-convert-a-byte-count-into-human-kib-mib-etc-like-du-ls1
bytestohuman() {
    local L_BYTES="${1:-0}"
    local L_PAD="${2:-no}"
    local L_BASE="${3:-1024}"
    BYTESTOHUMAN_RESULT=$(awk -v bytes="${L_BYTES}" -v pad="${L_PAD}" -v base="${L_BASE}" 'function human(x, pad, base) {
         if(base!=1024)base=1000
         basesuf=(base==1024)?"iB":"B"

         s="BKMGTEPYZ"
         while (x>=base && length(s)>1)
               {x/=base; s=substr(s,2)}
         s=substr(s,1,1)

         xf=(pad=="yes") ? ((s=="B")?"%5d   ":"%8.2f") : ((s=="B")?"%d":"%.2f")
         s=(s!="B") ? (s basesuf) : ((pad=="no") ? s : ((basesuf=="iB")?(s "  "):(s " ")))

         return sprintf( (xf " %s\n"), x, s)
      }
      BEGIN{print human(bytes, pad, base)}')
    return $?
}

bytestohuman "$1"; echo "${BYTESTOHUMAN_RESULT}.";
