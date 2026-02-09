<?php
/*
Plugin Name: IBM i Admin Message
Description: Adds a groovy custom message to the top of your WordPress Admin Screen.
Version: 1.1
Author: Nick Litten
*/

if (!defined('ABSPATH')) {
  exit; // Exit if accessed directly
}

/*
Define a function named 'ibmi_admin_message' which we can trigger at anytime
*/
function ibmi_admin_message()
{
  echo '<h2 style="text-align:center; color:blue;">Woooooo Two! I am powered by IBM i and WordPress</h2>';
}

/* 
admin_head: Targets the backend/admin dashboard 
*/
add_action ('admin_head', 'ibmi_admin_message');
