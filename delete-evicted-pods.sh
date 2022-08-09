#!/bin/bash -xv

NAMESPACES=$(kubectl get pods -A | grep Evicted | cut -f1 -d " " | uniq)
for NS in $NAMESPACES
do
	PODS=$(kubectl get pods -n $NS | grep Evicted | cut -f1 -d " ")
	i=0
	for POD in "$PODS"
	do
	  kubectl delete pods -n $NS $POD
	  ((i=i+1))
	  echo "+++++++Deleted $i pods +++++++"
	done
done
