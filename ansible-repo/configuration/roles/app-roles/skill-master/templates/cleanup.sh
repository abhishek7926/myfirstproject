#!/bin/bash
for f in /data/skillmaster/MettlDb/*/;
#for f in /data/skillmaster/backup/04-03-2016_02-30-03/*/;
        do
                cd $f
                echo "cleaning $f"
                > messages.log
                rm -rf upgrade
                rm -rf upgrade_backup
                rm -rf  nioneo_logical.log.v*
                cd $f/index
                rm -rf lucene.log.v*
                cd ..
                echo "++++++++++++++++++++++++"

        done
