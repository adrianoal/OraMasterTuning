#!/bin/bash
#for i in $(seq 4)
#do echo $i;
#done

./executa_update_orders.sh >/dev/null &
pid1=$!
./executa_update_orders.sh >/dev/null &
pid2=$!
./executa_update_orders.sh >/dev/null &
pid3=$!
./executa_update_orders.sh >/dev/null &
pid4=$!

wait $pid1
wait $pid2
wait $pid3
wait $pid4
echo 'O script finalizou a sua execucao'