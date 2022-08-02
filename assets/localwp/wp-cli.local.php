<?php
/**
 * WP-CLI + LocalWP Configuration
 *
 * @since Tuesday, August 2, 2022
 */

$sock = file_exists( __DIR__ . '/wp-cli.local.sock' )
	? trim( file_get_contents( __DIR__ . '/wp-cli.local.sock' ) )
	: '';

define( 'DB_HOST', "localhost:{$sock}" );
define( 'WP_DEBUG', false );

error_reporting( E_ERROR ); // For WP-CLI don't report anything but errors (supress warnings).

unset( $sock );