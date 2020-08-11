#!/bin/bash
sqlplus soe/soe@pdbxe @04_update_orders.sql << EOF
exit
EOF
