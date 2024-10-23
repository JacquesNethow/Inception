VOL_BASE_DIR = /home/jramondo/data
MARIADB_VOL_DIR = $(VOL_BASE_DIR)/mariadb
WP_VOL_DIR = $(VOL_BASE_DIR)/wordpress


all: directories hosts
	sudo docker-compose -f ./srcs/docker-compose.yml up -d


directories:
	@sudo mkdir -p $(MARIADB_VOL_DIR)
	@sudo mkdir -p $(WP_VOL_DIR)
	@sudo chmod -R 777 $(VOL_BASE_DIR)

down: 
	sudo docker-compose -f ./srcs/docker-compose.yml down

clean:
	cd srcs && sudo docker-compose down
	sudo docker system prune -af --volumes
	sudo docker volume prune -f
	@docker volume rm mariadb_volumes -f
	@docker volume rm wordpress_volume -f
	sudo rm -rf $(VOL_BASE_DIR)
	sudo sed -in '/127.0.0.1 jramondo.42.fr/d' /etc/hosts
hosts:
	grep -qE '127.0.0.1[[:space:]]+jramondo.42.fr' /etc/hosts || echo '127.0.0.1 jramondo.42.fr' | sudo tee -a /etc/hosts

re: clean all

.PHONY: all directories clean hosts re