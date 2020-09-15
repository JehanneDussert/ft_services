function kdeploy () {
	for service in "$@"
	do
		printf "\tBuilding \e[1;95m$service\e[0m image...\n"
		docker build -t ${service}_img ./srcs/$service/ >/dev/null
		printf "\tCreating \e[1;93m$service\e[0m container...\n"
		kubectl apply -f ./srcs/$service.yaml # 1>/dev/null
	done
}

function clean () {
	for service in "$@"
	do
		echo "\e[92mCleaning $service...\e[m"
		kubectl delete -f ./srcs/$service.yaml 2>/dev/null 1>&2
	done
}

function kre () {
	clean $@
	kdeploy $@
}

function watch_services () { watch kubectl get all --all-namespaces }

function sshnginx () { rm -f ${HOME}/.ssh/known_hosts &&
	nginx_url=$(kubectl describe service/nginx-service | grep IPAllocated | cut -d "\"" -f 2) &&
	echo "\e[93mNo password needed 👀\e[0m" && ssh username@${nginx_url} -p 22
}

function dockexec () {
	service="$1";
	dockerfile_path=./srcs/$service/
	cmd="sh"
	if [ -n "$2" ]; then dockerfile_path="$2" fi
	if [ -n "$3" ]; then cmd="$3" fi
	docker build -t $service-img $dockerfile_path && \
	docker run --rm --name coucou -d -it $service-img && \
	docker exec -it coucou $cmd; docker kill coucou 2>/dev/null 1>&2
}

function kexec () {
	if [ -z "$1" ]; then echo "Give me a pod"; return 1; fi
	if [ -z "$2" ]; then 2="sh" ; fi
	1=$(echo $1 | cut -d '/' -f 2)
	kubectl exec -it $1 -- $2;
}

function klogs () {
	if [ -z "$1" ]; then echo "Give me a pod"; return 1; fi
	kubectl logs $1
}
