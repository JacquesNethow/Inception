#!/bin/bash
s
WP_PATH="/var/www/wordpress"

# Função para executar o WP-CLI com o caminho do WordPress
wp() {
  /usr/local/bin/wp --allow-root --path="$WP_PATH" "$@"
}

# Verifica se o WordPress já está instalado
if ! wp core is-installed; then
  wp core install \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PWD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --url="$WP_URL"
  # Instala o WordPress

  # Atualiza a descrição do blog
  wp option update blogdescription "$WP_SUB_TITLE"
  
  # Cria um novo usuário
  wp user create "$WP_USER" "$WP_USER_EMAIL" --role=author --user_pass="$WP_USER_PWD"
  
  # Atualiza todos os plugins
  wp plugin update --all

  # Define as permissões corretas para os arquivos do WordPress
  chown -R www-data:www-data "$WP_PATH"
  find "$WP_PATH" -type d -exec chmod 755 {} \;
  find "$WP_PATH" -type f -exec chmod 644 {} \;
fi

# Executa o PHP-FPM
exec php-fpm8.2 -F

