<?php
/**
 * La configuration de base de votre installation WordPress.
 *
 * Ce fichier contient les réglages de configuration suivants : réglages MySQL,
 * préfixe de table, clés secrètes, langue utilisée, et ABSPATH.
 * Vous pouvez en savoir plus à leur sujet en allant sur
 * {@link http://codex.wordpress.org/fr:Modifier_wp-config.php Modifier
 * wp-config.php}. C’est votre hébergeur qui doit vous donner vos
 * codes MySQL.
 *
 * Ce fichier est utilisé par le script de création de wp-config.php pendant
 * le processus d’installation. Vous n’avez pas à utiliser le site web, vous
 * pouvez simplement renommer ce fichier en "wp-config.php" et remplir les
 * valeurs.
 *
 * @package WordPress
 */

// ** Réglages MySQL - Votre hébergeur doit vous fournir ces informations. ** //
/** Nom de la base de données de WordPress. */
define('DB_NAME', 'wordpress');

/** Utilisateur de la base de données MySQL. */
define('DB_USER', 'wordpress_user');

/** Mot de passe de la base de données MySQL. */
define('mysql-pass', '1234');

/** Adresse de l’hébergement MySQL. */
define('DB_HOST', 'localhost');

/** Jeu de caractères à utiliser par la base de données lors de la création des tables. */
define('DB_CHARSET', 'utf8');

/** Type de collation de la base de données.
  * N’y touchez que si vous savez ce que vous faites.
  */
define('DB_COLLATE', '');

/**#@+
 * Clés uniques d’authentification et salage.
 *
 * Remplacez les valeurs par défaut par des phrases uniques !
 * Vous pouvez générer des phrases aléatoires en utilisant
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ le service de clefs secrètes de WordPress.org}.
 * Vous pouvez modifier ces phrases à n’importe quel moment, afin d’invalider tous les cookies existants.
 * Cela forcera également tous les utilisateurs à se reconnecter.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'rrG9}Ju_>]UdXU:5RW)6(%[+L^mkt:, rhFs.E|xd_&|_n@$H5,5OpF>h>cm~j< ');
define('SECURE_AUTH_KEY',  '{S|8+va<d;YJZy$9H.N=L|PrJI&wy&{ev<[TpZ-wB?%h:#|giJqevMC B-3%X8dn');
define('LOGGED_IN_KEY',    'p5gBF&V8[,(3m`+hV9,yb|0+6v-<#4;#R8`F*}>P)>QA!T-|3+uq`o?nFFuQjz| ');
define('NONCE_KEY',        '+40% GnK-:q,~{hD);H+F-DI7|1+^3_P|ks:V:8RYMLM|8j8GA*kj%G{/iya.i={');
define('AUTH_SALT',        '[54TOc:dJQ]i~!#%8}eR4eizNT9Z~/%ujw IX-eCAMc9M86dC^G9.]+3XF{Cdq]B');
define('SECURE_AUTH_SALT', 'YHwp*[yAhToN|j5@,3O.oq:iN|:D) `RUxo+SOIn3Ii(xWZI/CT^kS~TzV3||}Y-');
define('LOGGED_IN_SALT',   'nVnViAMW08M}Sp9WSc]v^PN5f6DlV.=n.!~Y#z|ID|W}7n6aVB2z`&%VZGHfp{cW');
define('NONCE_SALT',       'Cd+q)<e+ddFtyF&%^R9U+jUnl/;=1CuvR,#5$|lSL9|Vh$/sAM}lsDp.|W1Cl-p{');
/**#@-*/

/**
 * Préfixe de base de données pour les tables de WordPress.
 *
 * Vous pouvez installer plusieurs WordPress sur une seule base de données
 * si vous leur donnez chacune un préfixe unique.
 * N’utilisez que des chiffres, des lettres non-accentuées, et des caractères soulignés !
 */
$table_prefix = 'wp_';

/**
 * Pour les développeurs : le mode déboguage de WordPress.
 *
 * En passant la valeur suivante à "true", vous activez l’affichage des
 * notifications d’erreurs pendant vos essais.
 * Il est fortemment recommandé que les développeurs d’extensions et
 * de thèmes se servent de WP_DEBUG dans leur environnement de
 * développement.
 *
 * Pour plus d’information sur les autres constantes qui peuvent être utilisées
 * pour le déboguage, rendez-vous sur le Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

/* C’est tout, ne touchez pas à ce qui suit ! Bonne publication. */

/** Chemin absolu vers le dossier de WordPress. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Réglage des variables de WordPress et de ses fichiers inclus. */
require_once(ABSPATH . 'wp-settings.php');
