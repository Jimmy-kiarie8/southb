-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 19, 2024 at 08:00 AM
-- Server version: 10.11.8-MariaDB-1
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `southb`
--

-- --------------------------------------------------------

--
-- Table structure for table `adjusted_products`
--

CREATE TABLE `adjusted_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `adjustment_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

CREATE TABLE `adjustments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `reference` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `location`, `created_at`, `updated_at`) VALUES
(1, 'HQ', 'Nairobi', '2024-04-24 16:54:12', '2024-04-24 16:54:12');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_code` varchar(255) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category_code`, `category_name`, `created_at`, `updated_at`) VALUES
(1, 'CT0001', 'FOOD', NULL, NULL),
(2, 'CT0002', 'SNACKS', NULL, NULL),
(3, 'CT0003', 'BEVERAGES', NULL, NULL),
(4, 'CT0004', 'SANITARY', NULL, NULL),
(5, 'CT0005', 'DETERGENTS', NULL, NULL),
(6, 'CT0006', 'COSMETICS', NULL, NULL),
(7, 'CT0007', 'PERSONAL_EFFECT', NULL, NULL),
(8, 'CT0008', 'MEDICATION', NULL, NULL),
(9, 'CT0009', 'UTENSIL', NULL, NULL),
(10, 'CT0010', 'MILK', NULL, NULL),
(11, 'CT0011', 'STATIONARY', NULL, NULL),
(12, 'CT0012', 'ELECTRICALS', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `close_days`
--

CREATE TABLE `close_days` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `cb1` int(11) NOT NULL DEFAULT 0,
  `cb2` int(11) NOT NULL DEFAULT 0,
  `kcb` int(11) NOT NULL DEFAULT 0,
  `equity` int(11) NOT NULL DEFAULT 0,
  `cash` int(11) NOT NULL DEFAULT 0,
  `credit_paid` int(11) NOT NULL DEFAULT 0,
  `credit` int(11) NOT NULL DEFAULT 0,
  `cheque` int(11) NOT NULL DEFAULT 0,
  `total` int(11) NOT NULL DEFAULT 0,
  `date` date NOT NULL,
  `total_sales` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `currency_name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `symbol` varchar(255) NOT NULL,
  `thousand_separator` varchar(255) NOT NULL,
  `decimal_separator` varchar(255) NOT NULL,
  `exchange_rate` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `currency_name`, `code`, `symbol`, `thousand_separator`, `decimal_separator`, `exchange_rate`, `created_at`, `updated_at`) VALUES
(1, 'Kenya Shillings', 'KSH', 'KSH', ',', '.', NULL, '2023-02-04 17:44:34', '2023-02-04 17:44:34');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `customer_email` varchar(255) DEFAULT NULL,
  `customer_phone` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customer_name`, `code`, `customer_email`, `customer_phone`, `city`, `country`, `address`, `created_at`, `updated_at`) VALUES
(1, 'walkin', 'CS001', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dailymails`
--

CREATE TABLE `dailymails` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `last_job` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `reference` varchar(255) NOT NULL,
  `details` text DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `category_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_no` varchar(255) NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `balance` decimal(8,2) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Unpaid',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_payments`
--

CREATE TABLE `invoice_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `reference` varchar(255) NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lpos`
--

CREATE TABLE `lpos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `reference` varchar(255) NOT NULL,
  `supplier_id` bigint(20) UNSIGNED DEFAULT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `tax_percentage` int(11) NOT NULL DEFAULT 0,
  `tax_amount` int(11) NOT NULL DEFAULT 0,
  `discount_percentage` int(11) NOT NULL DEFAULT 0,
  `discount_amount` int(11) NOT NULL DEFAULT 0,
  `shipping_amount` int(11) NOT NULL DEFAULT 0,
  `total_amount` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lpo_details`
--

CREATE TABLE `lpo_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `lpo_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `unit_price` int(11) NOT NULL,
  `sub_total` int(11) NOT NULL,
  `product_discount_amount` int(11) NOT NULL,
  `product_discount_type` varchar(255) NOT NULL DEFAULT 'fixed',
  `product_tax_amount` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) DEFAULT NULL,
  `collection_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `disk` varchar(255) NOT NULL,
  `conversions_disk` varchar(255) DEFAULT NULL,
  `size` bigint(20) UNSIGNED NOT NULL,
  `manipulations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `custom_properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `generated_conversions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `responsive_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `order_column` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 2),
(1, 'App\\Models\\User', 4),
(1, 'App\\Models\\User', 6),
(1, 'App\\Models\\User', 7),
(1, 'App\\Models\\User', 8),
(2, 'App\\Models\\User', 1),
(3, 'App\\Models\\User', 3),
(3, 'App\\Models\\User', 9),
(3, 'App\\Models\\User', 10);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'edit_own_profile', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(2, 'access_user_management', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(3, 'show_total_stats', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(4, 'show_month_overview', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(5, 'show_weekly_sales_purchases', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(6, 'show_monthly_cashflow', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(7, 'show_notifications', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(8, 'access_products', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(9, 'create_products', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(10, 'show_products', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(11, 'edit_products', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(12, 'delete_products', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(13, 'access_product_categories', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(14, 'print_barcodes', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(15, 'access_adjustments', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(16, 'create_adjustments', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(17, 'show_adjustments', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(18, 'edit_adjustments', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(19, 'delete_adjustments', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(20, 'access_quotations', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(21, 'create_quotations', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(22, 'show_quotations', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(23, 'edit_quotations', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(24, 'delete_quotations', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(25, 'create_quotation_sales', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(26, 'send_quotation_mails', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(27, 'access_expenses', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(28, 'create_expenses', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(29, 'edit_expenses', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(30, 'delete_expenses', 'web', '2023-02-04 17:44:32', '2023-02-04 17:44:32'),
(31, 'access_expense_categories', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(32, 'access_customers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(33, 'create_customers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(34, 'show_customers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(35, 'edit_customers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(36, 'delete_customers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(37, 'access_suppliers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(38, 'create_suppliers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(39, 'show_suppliers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(40, 'edit_suppliers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(41, 'delete_suppliers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(42, 'access_sales', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(43, 'create_sales', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(44, 'show_sales', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(45, 'edit_sales', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(46, 'delete_sales', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(47, 'create_pos_sales', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(48, 'access_sale_payments', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(49, 'access_sale_returns', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(50, 'create_sale_returns', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(51, 'show_sale_returns', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(52, 'edit_sale_returns', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(53, 'delete_sale_returns', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(54, 'access_sale_return_payments', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(55, 'access_purchases', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(56, 'create_purchases', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(57, 'show_purchases', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(58, 'edit_purchases', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(59, 'delete_purchases', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(60, 'access_purchase_payments', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(61, 'access_purchase_returns', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(62, 'create_purchase_returns', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(63, 'show_purchase_returns', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(64, 'edit_purchase_returns', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(65, 'delete_purchase_returns', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(66, 'access_purchase_return_payments', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(67, 'access_reports', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(68, 'access_currencies', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(69, 'create_currencies', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(70, 'edit_currencies', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(71, 'delete_currencies', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(72, 'access_settings', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(73, 'access_invoices', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(74, 'create_invoices', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(75, 'show_invoices', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(76, 'edit_invoices', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(77, 'delete_invoices', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(78, 'access_transfers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(79, 'create_transfers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(80, 'show_transfers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(81, 'edit_transfers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(82, 'delete_transfers', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(83, 'access_branches', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(84, 'create_branches', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(85, 'show_branches', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(86, 'edit_branches', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33'),
(87, 'delete_branches', 'web', '2023-02-04 17:44:33', '2023-02-04 17:44:33');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_code` varchar(255) DEFAULT NULL,
  `product_barcode_symbology` varchar(255) DEFAULT NULL,
  `product_quantity` int(11) DEFAULT NULL,
  `product_cost` decimal(8,2) DEFAULT NULL,
  `product_price` decimal(8,2) DEFAULT NULL,
  `wholesale_price` decimal(10,0) DEFAULT NULL,
  `product_unit` varchar(255) DEFAULT NULL,
  `product_stock_alert` int(11) DEFAULT NULL,
  `product_order_tax` int(11) DEFAULT NULL,
  `product_tax_type` tinyint(4) DEFAULT NULL,
  `product_note` text DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `product_name`, `product_code`, `product_barcode_symbology`, `product_quantity`, `product_cost`, `product_price`, `wholesale_price`, `product_unit`, `product_stock_alert`, `product_order_tax`, `product_tax_type`, `product_note`, `supplier_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, '210 2KG SIFTED MAIZE MEAL', 'PD0001', NULL, -1, 191.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-22 07:27:12'),
(2, 1, 'SOKO MAIZE MEAL 2KG', '6161102170023', 'C128', -1, 125.00, 145.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:56:48'),
(3, 2, 'RINGOZ BARBEQUE', '6161114160128', 'C128', -1, 8.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-07-23 08:25:01'),
(4, 1, 'AJAB FORTIFIED ALL PURPOSE HOME BAKING FLOUR 2KG', '6161113940141', 'C128', -1, 168.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 13:55:37'),
(5, 3, 'SAFI 500ML ', 'PD0005', NULL, -1, 16.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-22 07:06:25'),
(6, 3, 'SAFI 1LTR', 'PD0006', NULL, -1, 32.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-22 07:21:14'),
(7, 3, 'FANTA ORANGE 350ML', '90377884', 'C128', NULL, 38.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:10:15'),
(8, 3, 'SPRITE LEMON LIME 500ML', '54491069', 'C128', -1, 50.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-07-11 06:01:08'),
(9, 3, 'FANTA BLACKCURRANT  350ML', '42116479', 'C128', -1, 38.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-22 07:06:11'),
(10, 3, 'FANTA BLACKCURRANT 500ML', '50112753', 'C128', NULL, 50.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:02:45'),
(11, 3, 'FANTA ORANGE 500ML', '40822938', 'C128', NULL, 50.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:02:14'),
(12, 3, 'COCACOLA 500ML ', 'PD0012', NULL, NULL, 50.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(13, 3, 'COCACOLA 350ML ', 'PD0013', NULL, NULL, 38.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(14, 3, 'DAIMA MILK DRINK VANILLA 500ML', 'PD0014', NULL, NULL, 84.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(15, 3, 'DAIMA MILK DRINK STRAWBERRY 500ML', '6164004562187', 'C128', NULL, 84.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:46:41'),
(16, 3, 'ROYCO BEEF MZ MIX SATCHET 12G', '6161115175138', 'C128', NULL, 7.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:53:13'),
(17, 1, 'ZESTA RED PLUM JAM 200GMS', '6162000010022', 'C128', NULL, 79.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:11:13'),
(18, 1, 'ZESTA MIXED FRUIT JAM 500GMS', '6162000010268', 'C128', NULL, 229.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:12:08'),
(19, 3, 'BLUEBAND ORIGINAL 250G ', 'PD0019', NULL, NULL, 132.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(20, 1, 'BLUEBAND ORIGINAL 100G', '61614000', 'C128', NULL, 65.00, 75.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:56:55'),
(21, 3, 'GOFRUT ORANGE 1 LITRE', '6161104405215', 'C128', NULL, 131.00, 170.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:15:44'),
(22, 3, 'GOFRUT LEMON MINT 1 LITRE', '6161104405246', 'C128', NULL, 142.00, 170.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:07:16'),
(23, 3, 'GOFRUT ORANGE 250ML ', 'PD0023', NULL, NULL, 42.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(24, 3, 'GOFRUT LEMON MINT 250ML ', 'PD0024', NULL, NULL, 42.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(25, 3, 'GOFRUT APPLE 250ML', 'PD0025', NULL, NULL, 42.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(26, 3, 'GOFRUT ORANGE 250ML', '6161104405260', 'C128', NULL, 42.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:25:23'),
(27, 3, 'GOFRUT MANGO 1LITRE', '6161104405222', 'C128', NULL, 131.00, 170.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:17:25'),
(28, 3, 'QUENCHER PINAPPLE 1 LITRE ', 'PD0028', NULL, NULL, 142.00, 190.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(29, 3, 'ZESTA HOT & SWEET SAUCE 250G', '6162000049282', 'C128', NULL, 58.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:50:50'),
(30, 3, 'SUNTOP BLACKCURRANT 125ML', '6162008400061', 'C128', NULL, 21.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:34:19'),
(31, 1, 'INDOMIE CHICKEN FLAVOUR 120G', '089686120660', 'C128', NULL, 37.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:35:19'),
(32, 3, 'AFIA MANGO 500ML', '6008459000453', 'C128', NULL, 63.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:38:18'),
(33, 3, 'AFIA MIXED FRUIT  300ML', 'PD0033', NULL, NULL, 43.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(34, 4, 'BELLA WHITE TISSUE', '6164000242533', 'C128', NULL, 30.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:00:44'),
(35, 4, 'DAWN PEKEE POA ', 'PD0035', NULL, NULL, 15.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(36, 4, 'TULIPS SUPER SOFT TISSUE', '6164000365355', 'C128', NULL, 16.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:01:23'),
(37, 1, 'DAAWAT LONG GRAIN RICE  1KG', 'PD0037', NULL, NULL, 154.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(38, 1, 'DAAWAT SPHAGETTI GREEN LABEL  400G ', 'PD0038', NULL, NULL, 72.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(39, 1, 'KABRAS SUGAR 1KG', '6161104471210', 'C128', NULL, 215.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:53:18'),
(40, 1, 'KABRAS SUGAR 2KG', '6161104471319', 'C128', NULL, 290.00, 350.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:53:45'),
(41, 1, 'SOKO MAIZE MEAL 1KG', '6161102170030', 'C128', -1, 64.00, 75.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 02:38:39'),
(42, 1, 'PEMBE MAIZE MEAL 2KG', '6009627050010', 'C128', -1, 129.00, 145.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 16:30:54'),
(43, 1, 'NDOVU ALL PURPOSE FLOUR 2KG', '6161103620015', 'C128', -2, 160.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:38:09'),
(44, 1, 'AJAB1KG HOME BAKING FLOUR 1KG', '6161113940134', 'C128', NULL, 87.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:10:57'),
(45, 5, 'ARIEL FRESH SPRING CLEAN 20', '8700216079570', 'C128', NULL, 7.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:36:27'),
(46, 5, 'ARIEL FRESH LAVENDAR CLEAN 20G', '8700216074568', 'C128', NULL, 6.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:32:07'),
(47, 5, 'ARIEL FRESH FLORAL CLEAN 200G', '8006540909911', 'C128', NULL, 56.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 09:52:56'),
(48, 5, 'ARIEL SPRING CLEAN200G', '8700216079693', 'C128', NULL, 56.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 09:54:38'),
(49, 5, 'ARIEL FRESH SPRING CLEAN 500G', 'PD0049', NULL, NULL, 200.00, 230.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(50, 5, 'ARIEL FRESH FLORAL CLEAN 500G', 'PD0050', NULL, NULL, 200.00, 230.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(51, 5, 'KLEESOFT ANTI-BACTERIA 500G', '6203012970796', 'C128', NULL, 75.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 09:12:29'),
(52, 5, 'JIK 750ML', 'PD0052', NULL, NULL, 198.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(53, 4, 'ALWAYS PINK COTTON SOFT', '8001841739991', 'C128', NULL, 57.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:45:38'),
(54, 6, 'ARIMIS 200ML', '6008677006053', 'C128', NULL, 95.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:11:01'),
(55, 7, 'ARIMIS 50ML', '6008677006039', 'C128', NULL, 29.00, 45.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:12:43'),
(56, 7, 'BABYCARE JELLY  55G', '6203005140014', 'C128', NULL, 28.00, 45.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:47:54'),
(57, 7, 'BABYCARE JELLY 100G', '6203005140021', 'C128', NULL, 49.00, 75.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:47:06'),
(58, 2, 'BITEZ BARBEQUE 13G', '6161114160005', 'C128', NULL, 8.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:31:21'),
(59, 7, 'COLGATE HERBAL 35G', '6920354817809', 'C128', NULL, 65.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:07:00'),
(60, 7, 'COLGATE REGULAR 70G', '8850006324387', 'C128', -1, 115.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 14:44:28'),
(61, 7, 'COLGATE  MAXIMUN 15G', '8718951308213', 'C128', NULL, 35.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:12:01'),
(62, 1, 'COWBOY COOKING FAT  500G', '6161107774233', 'C128', NULL, 145.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:50:25'),
(63, 4, 'DOWMY VALLEY DEW 20ML', 'PD0063', NULL, NULL, 16.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(64, 4, 'DOWNY PERFUME COLLECTION 20ML', '8001090901040', 'C128', NULL, 16.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 23:31:17'),
(65, 1, 'FRESH FRI 2 LTRS', '6161106610235', 'C128', NULL, 500.00, 700.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:31:51'),
(66, 1, 'FRESH FRI 3LTRS', '6161106610242', 'C128', NULL, 750.00, 690.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:33:06'),
(67, 8, 'ENO LEMON ', 'PD0067', NULL, NULL, 11.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(68, 1, 'FAHARI YA KENYA 100G', '6009629720065', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:34:12'),
(69, 1, 'FAHARI YA KENYA 50G', '6009629720072', 'C128', -1, 19.00, 25.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 16:47:19'),
(70, 1, 'FAHARI YA KENYA 250G', '6009629720058', 'C128', NULL, 115.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:34:51'),
(71, 5, 'GEISHA GREEN 125G ', 'PD0071', NULL, NULL, 78.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(72, 5, 'GEISHA GREEN 225G', 'PD0072', NULL, NULL, 106.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(73, 5, 'GEISHA PINK 225G', 'PD0073', NULL, NULL, 105.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(74, 5, 'GEISHA WHITE 225G', 'PD0074', NULL, NULL, 106.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(75, 5, 'GEISHA WHITE 125G ', 'PD0075', NULL, NULL, 78.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(76, 5, 'JAMAA CREAM 800G', '6161101667197', 'C128', NULL, 170.00, 195.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:31:16'),
(77, 1, 'KASUKU COOKING FAT 500G', '6161101660051', 'C128', NULL, 150.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:49:37'),
(78, 1, 'KENSALT  200G', '6161101280037', 'C128', -1, 12.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 14:41:04'),
(79, 1, 'KENSALT  500G', '6161101280013', 'C128', NULL, 16.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:28:16'),
(80, 4, 'KISSKIDS MEDIUM ', 'PD0080', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(81, 4, 'KISSKIDS LARGE ', 'PD0081', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(82, 5, 'LAMZO ATI BACTERIA 200G', 'PD0082', NULL, NULL, 70.00, 85.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(83, 5, 'LANZO BLUEBERRY 200G', 'PD0083', NULL, NULL, 68.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(84, 5, 'LANZO MENTHOL 200G', '6161101662437', 'C128', NULL, 68.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:44:15'),
(85, 5, 'LANZO RASPBERRY 200G', '6161101662420', 'C128', NULL, 70.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:40:46'),
(86, 8, 'MARAMOJA ', 'PD0086', NULL, NULL, 7.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(87, 1, 'MELVINS TANGAWIZI TEA 50G', 'PD0087', NULL, NULL, 27.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(88, 5, 'MENENGAI CREAM SOAP 800G', '6161100907003', 'C128', NULL, 189.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:34:39'),
(89, 8, 'PANADOL EXTRA ', 'PD0089', NULL, NULL, 10.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(90, 3, 'RAHA DRINKING CHOCOLATE 100G', '6161104401644', 'C128', NULL, 88.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:28:32'),
(91, 1, 'RAHA DRINKING CHOCOLATE 20G', '6161104401613', 'C128', NULL, 9.00, 15.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 16:04:19'),
(92, 9, 'RHINO SAFETY MATCHES ', 'PD0092', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(93, 1, 'RINA 1LTR', '6161101661232', 'C128', NULL, 286.00, 400.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:39:57'),
(94, 1, 'ROYCO BEEF CUBE', '6162006602610', 'C128', -1, 110.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:44:26'),
(95, 4, 'SOFTCARE SANITARY PURPLE PAD', '6164004723144', 'C128', NULL, 57.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:40:14'),
(96, 5, 'SUNLIGHT LAVENDAR FRESH 200G ', 'PD0096', NULL, NULL, 90.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(97, 5, 'SUNLIGHT LAVENDAR 500G', 'PD0097', NULL, NULL, 173.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(98, 5, 'SUNLIGHT PINK DEST 500G', '6162006601262', 'C128', NULL, 173.00, 240.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 09:02:46'),
(99, 5, 'SUNLIGHT DEST PINK 30G', '6161115173523', 'C128', NULL, 9.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:41:33'),
(100, 5, 'SUNLIGHT LAVENDAR 25G', '6161115174995', 'C128', NULL, 9.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:39:13'),
(101, 5, 'SUNLIGHT LAVENDAR 200G', 'PD0101', NULL, NULL, 71.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(102, 5, 'SUNLIGHT DEST PINK 200G', 'PD0102', NULL, NULL, 63.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(103, 7, 'VASELINE PURE 25ML', '61600973', 'C128', NULL, 25.00, 45.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 00:56:34'),
(104, 7, 'VASELINE PURE 95ML', '61614185', 'C128', NULL, 102.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:05:23'),
(105, 7, 'VASELINE PURE 45ML', '61614147', 'C128', NULL, 64.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:07:58'),
(106, 1, 'WEETABIX ORIGINAL 37G', '5010029205084', 'C128', -1, 20.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 14:39:06'),
(107, 5, 'ZENTA BAR SOAP 800G', '6161110130835', 'C128', NULL, 143.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:35:22'),
(108, 5, 'STASOFT LAVENDAR FRESH 200ML', 'PD0108', NULL, NULL, 120.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(109, 1, 'GEISHA ROSE HONEY 125G', '6161115172595', 'C128', NULL, 78.00, 100.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:16:00'),
(110, 1, 'BLUE BAND ORIGINAL 500G', '6164004676228', 'C128', NULL, 243.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:55:49'),
(111, 2, 'TAMU TAMU RED', '6164001015983', 'C128', NULL, 8.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:30:49'),
(112, 7, 'LOGANS LEMON HANDWASH SOAP 500ML', 'PD0112', NULL, NULL, 130.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(113, 2, 'OREO ORIGINAL 28G', 'PD0113', NULL, NULL, 25.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(114, 2, 'DAIRY MILK  CHOCOLATE 10G', 'PD0114', NULL, NULL, 22.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(115, 2, 'DAIRY FRESH COFFEE FLAVOURED MILK 250ML', 'PD0115', NULL, NULL, 68.00, 75.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(116, 10, 'DAIMA WHOLE MILK 500ML', 'PD0116', NULL, NULL, 54.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(117, 10, 'BROOKSIDE FARM FRESH 200ML', '6161101000444', 'C128', -1, 31.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 16:13:56'),
(118, 10, 'JESA MILK STRAW 200ML', '6161103270425', 'C128', NULL, 31.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:36:49'),
(119, 2, 'PICK M PEEL 1 LITRE ', 'PD0119', NULL, NULL, 193.00, 210.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(120, 1, 'FRESH FRI 250ML', '6161106610532', 'C128', NULL, 76.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:30:50'),
(121, 1, 'FRESH FRI 500ML', '6161106610211', 'C128', NULL, 169.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:30:12'),
(122, 10, 'DAIMA FLAVOURED MILK CHCOLATE 250ML', 'PD0122', NULL, NULL, 50.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(123, 2, 'QUENCHER ORANGE 2 LTRS', 'PD0123', NULL, NULL, 306.00, 330.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(124, 1, 'NESCAFE CLASSIC 1.5G', '6161106962662', 'C128', NULL, 4.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:22:55'),
(125, 1, 'ROYCO MCHUZI MIX BEEF 200G', '6161100605442', 'C128', NULL, 130.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:13:34'),
(126, 5, 'VIM LAVENDAR FRESH 500G', 'PD0126', NULL, NULL, 100.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(127, 5, 'SUNLIGHT SOAP 175G', '6161100600270', 'C128', NULL, 63.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:02:12'),
(128, 4, 'CUSHY SERVIETTES 100 PIECES', 'PD0128', NULL, NULL, 75.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(129, 5, 'DOWMY LUXURIOUS 280ML', 'PD0129', NULL, NULL, 237.00, 280.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(130, 5, 'DOWNY SOFT 300ML', 'PD0130', NULL, NULL, 237.00, 280.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(131, 1, 'SUPALOAF 400G', '6161102320404', 'C128', -1, 60.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:42:36'),
(132, 1, 'BUTTERTOAST 400G', 'PD0132', NULL, NULL, 60.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(133, 1, 'FESTIVE BROWN BREAD 400G', '6161105070252', 'C128', -1, 60.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:16:23'),
(134, 7, 'ADORA HAIR FOOD 50G', 'PD0134', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(135, 7, 'BANSI HAIR FOOD 50G', 'PD0135', NULL, NULL, 45.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(136, 7, 'BAMSI HAIR FOOD 50G', 'PD0136', NULL, NULL, 45.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(137, 7, 'BAMSI HAIR4 FOOD 100G', '6164000838323', 'C128', NULL, 75.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:59:38'),
(138, 7, 'VESTLINE ALOE VERA 70G', '6201100031558', 'C128', NULL, 45.00, 55.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:21:33'),
(139, 7, 'BODY LUXE BODY CREAM 70G', '6201100031527', 'C128', NULL, 45.00, 55.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:12:57'),
(140, 7, 'BODY LUXE BODY CREAM 200G', '6201100030865', 'C128', NULL, 65.00, 85.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:14:41'),
(141, 7, 'KRIS I MISS YOU CASUAL 100ML ', 'PD0141', NULL, NULL, 45.00, 55.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(142, 7, 'KRIS I MISS YOU FEMININE 100ML', 'PD0142', NULL, NULL, 45.00, 55.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(143, 7, 'NICE AND LOVELY COCOA AMD SHEA BUTTER 200ML', '6161110963495', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:28:30'),
(144, 7, 'NICE AND LOVELY MILK LOTION 200ML', '6009622390821', 'C128', NULL, 0.00, 0.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:29:08'),
(145, 7, 'NICE AND LOVELY GLYCERINE BODY LOTION 200ML', '6161110963532', 'C128', NULL, 120.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:29:52'),
(146, 7, 'NICE AND LOVELY FRESH AND COOL 200ML', 'PD0146', NULL, NULL, 120.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(147, 7, 'AMARA GLYCERINE 200ML', '6161100045125', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:52:13'),
(148, 7, 'AMARA BODY LOTION RAAW SHEA 200ML', 'PD0148', NULL, NULL, 120.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(149, 7, 'AMARA COCOA BUTTER BODY LOTION 200ML', '6161100045279', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:47:09'),
(150, 7, 'AMARA BAOBAB LIGHT BODY LOTION 200ML', 'PD0150', NULL, NULL, 120.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(151, 7, 'AMARA BODY MILK BODY LOTION 200ML', '6161100045101', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:48:10'),
(152, 7, 'AMARA HYDRATING GLYCERINE BODY LOTION 400ML', '6161100043657', 'C128', NULL, 180.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:44:48'),
(153, 7, 'AMARA COCONUT BODY LOTION 400ML', 'PD0153', NULL, NULL, 180.00, 280.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(154, 7, 'AMARA FOR MEN BODY LOTION 400ML', '6761100043611', 'C128', NULL, 180.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:45:21'),
(155, 7, 'AMARA BODY MILK BODY LOTION 400ML ', 'PD0155', NULL, NULL, 180.00, 280.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(156, 7, 'AMARA COCOA BUTTER 400ML', 'PD0156', NULL, NULL, 180.00, 280.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(157, 10, 'MOUNT KENYA MILK 200ML', '6161100100107', 'C128', -1, 25.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:19:49'),
(158, 10, 'MOUNT KENYA MILK 500ML', '6161100100084', 'C128', -1, 45.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:52:06'),
(159, 11, 'KASUKU A4 64PGS RULED', '6161101536714', 'C128', NULL, 38.00, 45.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:00:33'),
(160, 11, 'KASUKU A5 32PGS MATHS', '6161101536516', 'C128', NULL, 15.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:40:32'),
(161, 11, 'KASUKU A5 48PGS MATHS', '6161101536547', 'C128', NULL, 15.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:36:42'),
(162, 11, 'KASUKU A5 64PGS RULED', '6161101536554', 'C128', NULL, 20.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:32:36'),
(163, 11, 'KASUKU A5 64PGS MATHS', '6161101536561', 'C128', NULL, 20.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:33:38'),
(164, 11, 'KASUKU A5 80PGS MATHS', '6161101536585', 'C128', -1, 25.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 16:41:08'),
(165, 11, 'KASUKU A5 96PGS MATHS', '6161101536608', 'C128', NULL, 30.00, 45.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:28:36'),
(166, 11, 'KASUKU A5 120PGS MATHS', '6161101536646', 'C128', NULL, 35.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:19:45'),
(167, 11, 'KASUKU A5 200PGS MATHS', '6161101536660', 'C128', -1, 54.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 16:41:08'),
(168, 11, 'KASUKU A4 48PGS MATHS', '6161101536707', 'C128', NULL, 31.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:56:49'),
(169, 11, 'A4 80 PGS KASUKU', 'PD0169', NULL, NULL, 46.00, 55.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(170, 4, 'KISSKIDS ', 'PD0170', NULL, NULL, 15.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(171, 3, 'SPRITE LEMON  LIME 1.25L', '5449000028976', 'C128', NULL, 104.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:37:48'),
(172, 3, 'COCA COLA ORIGINAL TASTE 1.25L', '5449000028921', 'C128', NULL, 104.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:18:52'),
(173, 3, 'FANTA ORANGE 1.25L', '5449000028938', 'C128', -1, 104.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:41:31'),
(174, 3, 'FANTA BLACK CURRANT 1.25L', '5449000113467', 'C128', NULL, 104.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:36:38'),
(175, 7, 'TEEPEE SHOE BRUSH G6', 'PD0175', NULL, NULL, 45.00, 55.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(176, 3, 'PREDATOR ENERGY DRINK 400ML', '5060608740253', 'C128', NULL, 50.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:15:07'),
(177, 3, 'RIBENA BLACK CURRANT 250ML', '61603028', 'C128', NULL, 81.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:20:12'),
(178, 7, 'LIUGEL SUPER GLUE CYANOACRYLATE ADHESIVE ', 'PD0178', NULL, NULL, 30.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(179, 7, 'ALTECO SUPER GLUE  3G', 'PD0179', NULL, NULL, 30.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(180, 11, 'BARJOTT OFFICE GLUE  90G', 'PD0180', NULL, NULL, 17.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(181, 11, 'SPRING FILE TIL-FILE EXECUTIVE A4', 'PD0181', NULL, NULL, 40.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(182, 5, 'DOFFI PASSION LEMON 500G', '6203012970499', 'C128', NULL, 80.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 09:09:27'),
(183, 5, 'DOFFI INNOCENT LILY 500G', '6203012970673', 'C128', NULL, 80.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 09:10:14'),
(184, 5, 'DOFFI MYSTERIOUS ORCHID 500G', '6203012970345', 'C128', NULL, 80.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 09:11:00'),
(185, 6, 'DEXE BLACK HAIR SHAMPOO 25ML', '799439315525', 'C128', NULL, 25.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:05:17'),
(186, 2, 'FRUIT CHUTNEY 15G', 'PD0186', NULL, NULL, 7.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(187, 3, 'ILARA YOGHURT MANGO 150G', 'PD0187', NULL, NULL, 55.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(188, 3, 'ILARA YOGHURT STRAWBERRY 150G', 'PD0188', NULL, NULL, 55.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(189, 3, 'ILARA YOGHURT VANILLA 150G', 'PD0189', NULL, NULL, 50.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(190, 3, 'ILARA YOGHURT VANILLA 250G', '6161101000833', 'C128', NULL, 65.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:09:21'),
(191, 3, 'ILARA YOGHURT PLAIN 250G', '6161107150808', 'C128', NULL, 68.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:08:42'),
(192, 9, 'STALLION PLASTIC CUP ORANGE', 'PD0192', NULL, NULL, 30.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(193, 9, 'STALLION PLASTIC CUP LIGHT GREEN', 'PD0193', NULL, NULL, 30.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(194, 9, 'CK PLASTIC CUP RED', 'PD0194', NULL, NULL, 40.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(195, 9, 'CK PLASTIC CUP BLUE', 'PD0195', NULL, NULL, 40.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(196, 7, 'KENPOLY SOAP CASE GREEN', 'PD0196', NULL, NULL, 50.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(197, 7, 'KENPOLY SOAP CASE PURPLE', 'PD0197', NULL, NULL, 50.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(198, 7, 'KENPOLY SOAP CASE ', 'PD0198', NULL, NULL, 50.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(199, 9, 'KENPOLY SNACK BOX', 'PD0199', NULL, NULL, 100.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(200, 7, 'BALOON FLATABLE', 'PD0200', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(201, 7, 'CANYE WOOD  MOSQUITO REPELLANT', 'PD0201', NULL, NULL, 3.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(202, 7, 'ARAVINDA WOOD MOSQUITO REPELLANT', 'PD0202', NULL, NULL, 3.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(203, 1, 'MILL BAKERS SOFT WHITE BREAD 400G', 'PD0203', NULL, NULL, 55.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(204, 1, 'KIENYEJI EGG ', 'PD0204', NULL, NULL, 17.00, 25.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(205, 1, 'EGG NORMAL', 'PD0205', NULL, -10, 15.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 16:58:58'),
(206, 9, 'ELLIOTS 2KG  ALL PURPOSE HOME BAKING FLOUR', 'PD0206', NULL, NULL, 191.00, 210.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(207, 12, 'AFRILIGHTING RECHARGABLE BULB 30W', 'PD0207', NULL, NULL, 350.00, 430.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(208, 12, 'OPTONICA LED BULB 9W', 'PD0208', NULL, NULL, 75.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(209, 12, 'MWANGAZA LED BULB 9W', 'PD0209', NULL, NULL, 65.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(210, 12, 'AFRILIGHTING LED BULB 10W', 'PD0210', NULL, NULL, 65.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(211, 6, 'CARO LIGHT GLYCERINE', 'PD0211', NULL, NULL, 25.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(212, 6, 'CHAPA MANDASHI BAKING POWDER 100G', 'PD0212', NULL, NULL, 31.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(213, 5, 'HARPIC 200ML', '6161100952447', 'C128', NULL, 100.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:58:53'),
(214, 5, 'ERIPRIDE TOILET CLEANER 750ML', 'PD0214', NULL, NULL, 200.00, 250.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(215, 1, 'BIRYANI 1/2 KG ', 'PD0215', NULL, NULL, 61.00, 75.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(216, 1, 'NJAHI 1KG ', 'PD0216', NULL, NULL, 150.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(217, 1, 'SUKARI 1/4 KG ', 'PD0217', NULL, NULL, 32.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(218, 1, 'SUKARI 1/2 KG ', 'PD0218', NULL, NULL, 65.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(219, 1, 'SINDANO RICE 1/2 KG ', 'PD0219', NULL, NULL, 45.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(220, 1, 'SINDANO RICE 1 KG ', 'PD0220', NULL, NULL, 90.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(221, 1, 'PISHORI RICE 1/2 KG ', 'PD0221', NULL, NULL, 85.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(222, 1, 'PISHORI RICE 1KG ', 'PD0222', NULL, NULL, 185.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(223, 7, 'BALOON ', 'PD0223', NULL, NULL, 5.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(224, 3, 'SPRITE LEMON 2L', '5449000004864', 'C128', NULL, 158.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:23:07'),
(225, 3, 'TUZO YOGHURT VANILLA 400G', '6161107151737', 'C128', NULL, 80.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:16:38'),
(226, 3, 'TUZO YOGHURT VANILLA 200G', '6161107151751', 'C128', NULL, 55.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:15:55'),
(227, 3, 'COCA COLA SODA 300ML', 'PD0227', NULL, NULL, 29.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(228, 3, 'FANTA ORANGE 300ML', 'PD0228', NULL, NULL, 29.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(229, 3, 'FANTA PASSION 300ML', 'PD0229', NULL, NULL, 29.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(230, 3, 'KREST COKE 300ML', 'PD0230', NULL, NULL, 29.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(231, 10, 'LATO MILK 500ML', '6164002812109', 'C128', -1, 52.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 16:15:46'),
(232, 10, 'BROOKSIDEMILK 500ML', '6161101000543', 'C128', -1, 55.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:19:49'),
(233, 10, 'TUZO LONG LIFE MILK', '6161101680295', 'C128', NULL, 60.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 14:56:38'),
(234, 5, 'TOPEX BLEACH 70ML', 'PD0234', NULL, NULL, 16.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(235, 1, 'CERELAC  WHEAT NESTLE  50G', 'PD0235', NULL, NULL, 83.00, 95.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(236, 2, 'CHOCO LOLLIPOP', 'PD0236', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(237, 2, 'KRACKLES BANG BANG CHILLI 30G', 'PD0237', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(238, 2, 'KRACKLES ZINGY SALT AND VINEGAR 30G', 'PD0238', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(239, 2, 'KRACKLES PERFECTLY SALTED 30G', 'PD0239', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(240, 2, 'KRACKLES BAR-B-QUE 30G', 'PD0240', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(241, 2, 'KRACKLES TINGLY CHEESE AND ONION 30G', 'PD0241', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(242, 2, 'KRACKLES TANGY TOMATO 30G', 'PD0242', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(243, 5, 'MORNING FRESH DISH WASHING PASTE 400G', 'PD0243', NULL, NULL, 208.00, 280.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(244, 1, 'INDOMIE BEEF FLAVOUR 120G', 'PD0244', NULL, NULL, 37.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(245, 4, 'ROYAL GOLD JUMBO TISSUE ROLL ', 'PD0245', NULL, NULL, 75.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(246, 1, 'PRESTIGE MARGARINE ORIGINAL 500G', 'PD0246', NULL, NULL, 200.00, 230.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(247, 1, 'KASUKU COOKING OIL 100G', 'PD0247', NULL, NULL, 39.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(248, 4, 'DAWN PEKEE WRAPPED 10 ROLLS', '46009614480767', 'C128', NULL, 226.00, 350.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:29:39'),
(249, 1, 'GLUCOSE PURE ENERGY 45G', '6008677002277', 'C128', NULL, 13.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:26:04'),
(250, 1, 'GLUCOSE MR ENERGY SATCHET 10G', '6164002595743', 'C128', NULL, 3.00, 5.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:24:21'),
(251, 9, 'MAXBRITE SCOURING WASHING ', 'PD0251', NULL, NULL, 5.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(252, 7, 'KIWI BLACK SHOE POLISH40ML', '6161108970030', 'C128', NULL, 110.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:44:57'),
(253, 3, 'LEMONADE SAFARI LIME 300ML', 'PD0253', NULL, NULL, 38.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(254, 2, 'DAIRY FRESH CHOCOLATE MILK 250ML', '6009610610276', 'C128', NULL, 68.00, 75.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:21:59'),
(255, 2, 'DAIRY FRESH STRAWBERRY FLAVOURED MILK 250ML', 'PD0255', NULL, NULL, 68.00, 75.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(256, 2, 'DAIRY FRESH BUBBLEGUM FLAVOURED MILK 250ML', 'PD0256', NULL, NULL, 68.00, 75.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(257, 2, 'DAIRY FRESH VANILLA FLAVOURED MILK 250ML', 'PD0257', NULL, NULL, 68.00, 75.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(258, 2, 'DAIRY FRESH BANANA MILK 250ML', '6009610610351', 'C128', NULL, 68.00, 75.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:21:03'),
(259, 3, 'MINUTE MAID TROPICAL 1L', '5449000195456', 'C128', NULL, 110.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:16:40'),
(260, 1, 'CADBURY COCOA SATCHET 20G', '7622210304087', 'C128', NULL, 35.00, 45.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:16:37'),
(261, 7, 'GILLETTE 2 RAZOR BLADE', 'PD0261', NULL, NULL, 45.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(262, 3, 'AFIA MANGO FRUIT  JUICE 300ML', 'PD0262', NULL, NULL, 43.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(263, 10, 'DAIMA FLAVOURED MILK VANILLA 250ML', '6164004510119', 'C128', NULL, 50.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:46:07'),
(264, 1, 'BUTTER TOAST SUPA 400G', '6161102320138', 'C128', NULL, 60.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:04:21'),
(265, 6, 'BUTTER TOAST BREAD 600G', '6161102320442', 'C128', NULL, 90.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 14:51:00'),
(266, 6, 'SULTANA OIL WITH COCONUT OIL 150ML', '6164000108693', 'C128', NULL, 65.00, 80.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:46:02'),
(267, 6, 'SULTANA OIL WITH COCONUT OIL 70ML', '6164000108761', 'C128', NULL, 35.00, 50.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:46:43'),
(268, 3, 'FANTA PASSION 2L', '5449000090096', 'C128', NULL, 155.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:21:19'),
(269, 2, 'GINGER NUVITA BISCUIT 3PC', 'PD0269', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(270, 2, 'HAPPY HAPPY SUN VEAT 2 SANDWICH', 'PD0270', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(271, 2, 'NUVITA NILK BISCUIT 5PC', '6161103943725', 'C128', NULL, 3.00, 5.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:55:23'),
(272, 2, 'NUVITA MILK BISCUIT 5PC', 'PD0272', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(273, 3, 'STEAM ENERGY DRINK 400ML', 'PD0273', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(274, 10, 'BROOKSIDE FRESH FARM MILK 250ML', '6009610610191', 'C128', NULL, 45.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:23:32'),
(275, 2, 'TOOGOODY TOFFEE', 'PD0275', NULL, NULL, 9.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(276, 10, 'BROOKSIDE LALA NATURAL 500G', '6161107150730', 'C128', NULL, 95.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:52:28'),
(277, 3, 'COCA COLA ORIGINAL 2L', '5449000000286', 'C128', NULL, 175.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:22:14'),
(278, 1, 'CHAPA MANDASHI  100G', '6161101661713', 'C128', -1, 31.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:50:54'),
(279, 9, 'SOKONI STEEL WOOL 15G', '6161101880084', 'C128', NULL, 3.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:06:36'),
(280, 2, 'BIG BOSS ENERGY', '6161103031972', 'C128', NULL, 5.00, 5.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:36:26'),
(281, 2, 'BIG BOSS YELLOW', '6161103032276', 'C128', NULL, 5.00, 5.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:37:19'),
(282, 2, 'TOOGOODY TOFFEE CHOCOLATE', 'PD0282', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(283, 1, 'KAVAGARA RAHA MAIZE MEAL 2KG', '792382315628', 'C128', NULL, 189.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:27:44'),
(284, 2, 'EXCEL PURE GLUCOSE ', 'PD0284', NULL, NULL, 15.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(285, 3, 'POWER PLAY 400ML', '5060466516632', 'C128', NULL, 50.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:05:29'),
(286, 2, 'BIG GIANT LOLLIPOP ', 'PD0286', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(287, 1, 'DOLA GOLD MAIZE FLOUR 2KGS', 'PD0287', NULL, NULL, 181.00, 195.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(288, 1, 'FAMILLA PURE 500G', 'PD0288', NULL, NULL, 78.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(289, 2, 'FRESH FRUITY CHEWING GUM', '6161112464679', 'C128', NULL, 4.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:18:30'),
(290, 3, 'STEAM ENERGY DRINK SCOTCH FLAVOURED 400ML', 'PD0290', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(291, 5, 'WHITE WASH WHITE 175G', '6009635140970', 'C128', -1, 40.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 23:04:47'),
(292, 5, 'PEGS PACKET 144PCS', 'PD0292', NULL, NULL, 130.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(293, 1, 'EXE ALL PURPOSE WHEAT FLOUR 2KG ', 'PD0293', NULL, NULL, 178.00, 205.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(294, 10, 'BROOKSIDE SWEET LALA 500ML', '6161107150709', 'C128', -1, 95.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 14:42:13'),
(295, 1, 'FESTIVE BREAD 400G', '6161105070238', 'C128', -1, 60.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:43:56'),
(296, 2, 'WHATSAPP GUM ', 'PD0296', NULL, NULL, 4.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(297, 9, 'SOKONI STEEL WOOL 75G', 'PD0297', NULL, NULL, 15.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(298, 10, 'DAIMA LON LIFE MILK ', 'PD0298', NULL, NULL, 60.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(299, 1, 'PILAU MASALA  SPICE 50G', '6161100912731', 'C128', NULL, 141.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:44:52'),
(300, 7, 'COLGATE HERBAL 70G', '6920354817816', 'C128', NULL, 108.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 00:36:33'),
(301, 5, 'OMO WASHING POWDER  500G', '6162006602740', 'C128', NULL, 188.00, 215.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 09:03:41'),
(302, 2, 'TOFFEE CO.', 'PD0302', NULL, NULL, 4.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(303, 1, 'AMAIZE MAIZE MEAL 2KG', '6161102170993', 'C128', NULL, 190.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:24:34'),
(304, 2, 'M.T KENYA YOGHURT VANILLA FLAVOURED 500ML', 'PD0304', NULL, NULL, 85.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(305, 2, 'M.T KENYA VANILLA FLAVOURED 150ML', 'PD0305', NULL, NULL, 25.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(306, 5, 'PEGS PLASTIC', 'PD0306', NULL, NULL, 15.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(307, 2, ' CAKE BUNS 6PCS', 'PD0307', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(308, 11, 'KASUKU A4 120PGS RULED', '6161101536776', 'C128', NULL, 65.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:05:09'),
(309, 1, 'MT YOGHURT VANILLA 150ML', 'PD0309', NULL, NULL, 25.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(310, 7, 'COLGATE TOOTH BRUSH DOUBLE ACTION ', 'PD0310', NULL, NULL, 42.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(311, 1, 'GILDA TOMATO PASTE PUREE 50G', 'PD0311', NULL, NULL, 11.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(312, 2, 'PK MENTHOL 4PELLETS', 'PD0312', 'C128', NULL, 6.00, 7.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:13:50'),
(313, 5, 'TOSS BLUE 500G', '6161101661867', 'C128', NULL, 160.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 09:00:08'),
(314, 1, 'FARAGELLO TOMATO PUREE PASTE 50G', 'PD0314', NULL, NULL, 13.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(315, 2, 'DAIRY MILK CHOCOLATE 35G', 'PD0315', NULL, NULL, 82.00, 110.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(316, 2, 'TROPICAL HEAT SALTED CRIPS 25G', '6161100911000', 'C128', NULL, 26.00, 30.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:11:29'),
(317, 2, 'TROPICAL HEAT TOMATO  25G', '6161100911024', 'C128', NULL, 26.00, 30.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:16:55'),
(318, 2, 'TROPICAL HEAT SALT VINEGAR 25G', '6161100911017', 'C128', NULL, 26.00, 30.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:21:27'),
(319, 2, 'TROPICAL HEAT TOMATO CRIPS 100G', '6161100914636', 'C128', NULL, 95.00, 110.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:10:04'),
(320, 2, 'TROPICAL HEAT CHILLI LEMON CRIPS 100G', '6161100910126', 'C128', -1, 95.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:17:32'),
(321, 2, 'TROPICAL HEAT CHEESE ONION 100G', '6161100910072', 'C128', NULL, 95.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:08:23'),
(322, 2, 'TROPICAL HEAT SALT VINEGAR CRIPS 100G', '6161100910027', 'C128', NULL, 95.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:05:03'),
(323, 2, 'TROPICAL HEAT SALT AND VINEGAR 50G', '6161100910010', 'C128', NULL, 50.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:14:05'),
(324, 2, 'TROPICAL HEAT CHEESE ONION 50G', '6161100910065', 'C128', NULL, 60.00, 65.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:20:11'),
(325, 2, 'TROPICAL HEAT CHILLI LEMON 50G', '6161100910119', 'C128', -1, 60.00, 65.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 01:28:10'),
(326, 2, 'TROPICAL HEAT TOMATO 50G', '6161100914582', 'C128', -1, 60.00, 65.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:04:24'),
(327, 4, 'SOFTCAR E DIAPER MEDIUM 9PCS', '6166000121924', 'C128', NULL, 130.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 21:19:17'),
(328, 7, 'DAWN PEKEE QUALITY ROLL', '6161100760226', 'C128', -1, 26.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 16:30:54'),
(329, 1, 'BUTTERFLY GREEN GRAMS 1KG', 'PD0329', NULL, NULL, 195.00, 210.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(330, 1, 'BUTTERFLY GREEN GRAMS 500G', 'PD0330', NULL, NULL, 95.00, 110.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(331, 7, 'EARBUDS CHICO', 'PD0331', NULL, -1, 13.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:47:50'),
(332, 1, 'RINA 2LTRS', '6161101661300', 'C128', NULL, 500.00, 700.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:40:38'),
(333, 5, 'SUNLIGHT WASHING LAVENDER POWDER 150G', '6161115173035', 'C128', NULL, 45.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 09:49:49'),
(334, 3, 'DELAMERE VANILLA 450G', '6164000033186', 'C128', NULL, 145.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:14:40'),
(335, 2, 'DELAMERE YOGHURT WITH REAL STRAWBERRIES', 'PD0335', NULL, NULL, 85.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(336, 2, 'DELAMERE LEMON BISCUIT 450G', '6164000033193', 'C128', -1, 145.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:15:06'),
(337, 3, 'DELMONTE MANGO 1LITRE', '024000150152', 'C128', NULL, 255.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:54:37'),
(338, 1, 'GITHAMBO PREMIUM TEA QUALITY BLACK TEA 500G', '792382463015', 'C128', NULL, 200.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:35:42'),
(339, 1, 'GITHAMBO PREMIUM TEA QUALITY BLACK TEA 240G', 'PD0339', NULL, NULL, 100.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(340, 1, 'GITHAMBO PREMIUM TEA QUALITY BLACK TEA 100G', '792382462995', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:29:31'),
(341, 1, 'GITHAMBO PREMIUM QUALITY TEA 50G', '792382462988', 'C128', NULL, 20.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:30:04'),
(342, 1, 'B B BREAD WHITE BREAD 200G', 'PD0342', NULL, NULL, 30.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(343, 3, 'DASANI DRINKING WATER 500ML', '87303322', 'C128', NULL, 23.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:30:01'),
(344, 3, 'DASANI DRINKING WATER 1 LITRE', 'PD0344', NULL, NULL, 48.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `products` (`id`, `category_id`, `product_name`, `product_code`, `product_barcode_symbology`, `product_quantity`, `product_cost`, `product_price`, `wholesale_price`, `product_unit`, `product_stock_alert`, `product_order_tax`, `product_tax_type`, `product_note`, `supplier_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(345, 3, 'MINUTE MAID TROPICAL400ML', '90399480', 'C128', NULL, 58.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:43:49'),
(346, 1, 'SOKO ATTA MARK1. 2KG', 'PD0346', NULL, NULL, 207.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(347, 1, 'WEETABIX ORIGINAL 210G', '6161114650605', 'C128', NULL, 180.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:32:39'),
(348, 4, 'BELLA SERVIETTE', '6161221010248', 'C128', NULL, 100.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:30:38'),
(349, 1, 'SIMBA MBILI CURRY POWDER 10G', '6161100140004', 'C128', NULL, 4.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:28:30'),
(350, 1, 'NDENGU 1/2 KG', 'PD0350', NULL, NULL, 51.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(351, 1, 'NDENGU 1KG ', 'PD0351', NULL, NULL, 101.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(352, 1, 'RINA COOKING OIL 3L', '6161101661249', 'C128', NULL, 907.00, 930.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:41:44'),
(353, 1, 'KANGORE GOLD 1KG', 'PD0353', NULL, NULL, 134.00, 170.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(354, 1, 'KANGORE GOLD 1/2KG', 'PD0354', NULL, NULL, 67.00, 85.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(355, 11, 'KASUKU A4 96PGS RULED', '6161101536752', 'C128', NULL, 55.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:11:01'),
(356, 1, 'DAILY LOAF 400G', 'PD0356', NULL, NULL, 50.00, 55.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(357, 3, 'MONSTER ENERGY DRINK', '5060896626741', 'C128', NULL, 200.00, 240.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:14:52'),
(358, 1, 'FAMILA UJIMIX SOUR PORRIDGE 1KG', 'PD0358', NULL, NULL, 145.00, 190.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(359, 7, 'KIWI BLACK SHOE POLISH 100ML/80G', '6161108970092', 'C128', NULL, 210.00, 240.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:42:47'),
(360, 6, 'NICE AND LOVELY BODY LOTION 100ML', 'PD0360', NULL, NULL, 90.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(361, 6, 'AMARA BODY MILK 100ML', '6161100043626', 'C128', NULL, 1.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:20:33'),
(362, 4, 'TAJI WHITE JUMBO TOILET ROLL', '6161109510396', 'C128', NULL, 78.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:16:32'),
(363, 6, 'ZOE SUMMER NIGHTS 400ML', '6161104344484', 'C128', NULL, 200.00, 260.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:53:45'),
(364, 6, 'ZOE SATIN JASMINE 200ML', '6161104343456', 'C128', NULL, 110.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:59:02'),
(365, 1, 'PERE CHEWY CANDY STICKS', 'PD0365', NULL, NULL, 4.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(366, 5, 'MENENGAI BAR SOAP 1KG', '6161100907034', 'C128', NULL, 0.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:36:10'),
(367, 1, 'ROYCO CHIKEN SACHET 12GM', 'PD0367', NULL, NULL, 5.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(368, 1, 'PILAU MASALA SACHET', '6161100912786', 'C128', NULL, 25.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:44:11'),
(369, 7, 'CARRIER BAG #15', 'PD0369', NULL, -1, 2.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 16:17:22'),
(370, 7, 'CARRIER BAG #22', 'PD0370', NULL, -1, 4.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:52:06'),
(371, 3, 'MINUTE MAID DELIGHT MANGO JUICE 1 L', '5449000180247', 'C128', NULL, 160.00, 190.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:16:10'),
(372, 3, 'MINUTE MAID DELIGHT TROPICAL JUICE 1L', 'PD0372', NULL, NULL, 160.00, 190.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(373, 3, 'MINUTE MAID DELIGHT APPLE DRINK 1 L', '5449000180292', 'C128', -1, 160.00, 190.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 00:09:39'),
(374, 3, 'MINUTE MAID DELIGHT MANGO 1L', 'PD0374', NULL, NULL, 110.00, 140.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(375, 6, 'BODY LUXE PERFUMED GLYCERINE ALOE VERA 50ML', '6201100030421', 'C128', NULL, 40.00, 60.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 19:34:27'),
(376, 6, 'BODY LUXE PERFUMED GLYCERINE ALOE VERA 100ML', '6201100031237', 'C128', NULL, 80.00, 110.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 19:35:47'),
(377, 6, 'YUAN BAI AIR FRESHNER LAVENDER 360ML', '6972865710131', 'C128', NULL, 150.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:20:01'),
(378, 6, 'YUAN BAI AIR FRESHNER FLORAL 360ML', '6972865710186', 'C128', NULL, 150.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:17:09'),
(379, 6, 'YUAN BAI AIR FRESHNER STRAWBERRY 360ML', '6972865710148', 'C128', NULL, 150.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:15:15'),
(380, 6, 'YUAN BAI AIR FRESHNER COCKTAIL FRUIT 360ML', '6972865710162', 'C128', NULL, 150.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:17:53'),
(381, 6, 'YUAN BAI AIR FRESHNER LEMON 360ML', '6972865710179', 'C128', NULL, 0.00, 0.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:16:25'),
(382, 3, 'SUNTOP MANGO AND APPLE 125ML', '6162008400023', 'C128', NULL, 21.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:33:40'),
(383, 3, 'SUNTOP BERRIES 125ML', '6162008400047', 'C128', NULL, 21.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:34:56'),
(384, 3, 'COCA COLA NO SUGAR 2L', 'PD0384', NULL, NULL, 175.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(385, 3, 'FANTA BLACK CURRENT 2L', '5449000022752', 'C128', -1, 175.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 14:53:52'),
(386, 3, 'FANTA ORANGE 2L', '5449000004840', 'C128', NULL, 175.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:19:38'),
(387, 3, 'SCHWEPPES BITTER LEMON 1.25 L', '5449000196903', 'C128', NULL, 104.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:38:23'),
(388, 1, 'RAHA DRINKING CHOCOLATE 200G', '6161104401651', 'C128', NULL, 180.00, 220.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:27:39'),
(389, 3, 'EPIC FRESH DRINKING WATER 5LTRS', 'PD0389', NULL, NULL, 75.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(390, 1, 'KENSALT SALT 1KG', '6161101280020', 'C128', NULL, 31.00, 45.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:28:49'),
(391, 1, ' HEROES TOMATO AND KETCHUP FLAVOUR 40G', 'PD0391', NULL, NULL, 50.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(392, 1, 'HEROES CHILLI CHEESE FLAVOUR 40G', '6161100917811', 'C128', NULL, 50.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:53:37'),
(393, 2, ' HEROES CHEESE AND ONION FLAVOUR 40G', 'PD0393', NULL, NULL, 50.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(394, 2, 'HEROES SALTED FLAVOUR 40G', '6161100917743', 'C128', NULL, 50.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:52:07'),
(395, 2, 'HEROES FRUIT CHUTNEY FLAVOUR 40G', 'PD0395', NULL, NULL, 50.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(396, 2, 'HEROES SALT AND VINEGAR FLAVOUR 40G', 'PD0396', NULL, NULL, 50.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(397, 3, 'MINUTE MAID NECTAR MANGO 1 LTR', 'PD0397', NULL, NULL, 162.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(398, 3, 'MINUTE MAID MANGO JUICE 400ML', 'PD0398', NULL, NULL, 58.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(399, 3, 'MINUTE MAID APPLE JUICE 400ML', '5449000188342', 'C128', NULL, 58.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:44:37'),
(400, 2, 'NUMBERS SNACK', 'PD0400', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(401, 7, 'PLANET BABY POWDER 50GM', 'PD0401', NULL, NULL, 17.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(402, 1, 'FESTIVE WHITE BREAD 600G', '6161105070283', 'C128', NULL, 90.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 14:51:31'),
(403, 7, 'T GUARD TOOTHPASTE 140G', 'PD0403', NULL, NULL, 45.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(404, 7, 'KALUMA TOOTHPASTE 150G', 'PD0404', NULL, NULL, 40.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(405, 7, 'BRIGHT UP TOOTHPASTE 150G', '6164004282313', 'C128', NULL, 37.00, 70.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:25:53'),
(406, 4, 'SUNNY GIRL SANITARY TOWELS', 'PD0406', NULL, NULL, 53.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(407, 7, 'GOOD DOCTOR TOOTHBRUSH', 'PD0407', NULL, NULL, 11.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(408, 6, 'NICE AND LOVELY PURE GLYCERINE 40ML', 'PD0408', NULL, NULL, 60.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(409, 7, 'GOOD DOCTOR JUNIOR TOOTH BRUSH', 'PD0409', NULL, NULL, 12.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(410, 6, 'STAR GIRL APPLE SHAMPOO 280ML', 'PD0410', NULL, NULL, 50.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(411, 6, 'STAR GIRL CONDITIONER 280ML', 'PD0411', NULL, NULL, 60.00, 85.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(412, 3, 'FANTA BLACK CURRENT 1LTR', 'PD0412', NULL, NULL, 61.00, 85.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(413, 3, 'COCA COLA 1LTR', 'PD0413', NULL, NULL, 61.00, 85.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(414, 3, 'SPRITE 1LTR', 'PD0414', NULL, NULL, 61.00, 85.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(415, 3, 'FANTA PASSION 1LTR', 'PD0415', NULL, NULL, 61.00, 85.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(416, 7, 'WISDOM TOOTH BRUSH', 'PD0416', NULL, NULL, 23.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(417, 2, 'TEA MBA BISCUITS', 'PD0417', NULL, NULL, 15.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(418, 2, 'PARLE MILK POWER BISCUITS', 'PD0418', NULL, NULL, 18.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(419, 5, 'JIK LEMON FRESH 250ML', 'PD0419', NULL, NULL, 120.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(420, 5, 'JIK COLOURS 250ML', '616111950030', 'C128', NULL, 215.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:30:37'),
(421, 5, 'SUNLIGHT SOAP 50G', '6161100600935', 'C128', NULL, 18.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:03:14'),
(422, 1, 'SOSSI CHUNKS 40G', '6008155007626', 'C128', NULL, 18.00, 30.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:31:35'),
(423, 2, 'MANJI MARIE BISCUITS 80G', '6161101251839', 'C128', NULL, 27.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:41:55'),
(424, 2, 'MANJI FAMIL;Y BISCUITS 80G', '6161101251846', 'C128', NULL, 27.00, 45.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:40:21'),
(425, 2, 'OREO ORIGINAL  BISCUITS 18.4G', '7622201385316', 'C128', NULL, 43.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:13:11'),
(426, 2, 'PARLE NICE BISCUITS', 'PD0426', NULL, NULL, 17.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(427, 2, 'NUVITA MILK BISCUITS 75G', '6161103941295', 'C128', NULL, 21.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:43:13'),
(428, 2, 'JOLLY BOY LOLLIPOP', 'PD0429', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(429, 2, 'SCOOTER SWEETS', 'PD0430', NULL, NULL, 13.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(430, 6, 'ARIMIS 90ML', '6008677006046', 'C128', NULL, 48.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:12:04'),
(431, 7, 'TAJ LIGHTER ', 'PD0432', NULL, NULL, 12.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(432, 5, 'IMPERIAL LEATHER MEN SPORT 150G', 'PD0433', NULL, NULL, 90.00, 110.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(433, 5, 'IMPREAL LEATHER MEN FRESH BURST 150G', 'PD0434', NULL, NULL, 90.00, 110.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(434, 5, 'IMPERIAL LEATHER MEN COOL 150G', 'PD0435', NULL, NULL, 90.00, 110.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(435, 5, 'IMPERIAL LEATHER CLASSIC 150G', '6161102011500', 'C128', NULL, 90.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:23:10'),
(436, 5, 'DETREX CITRONELLA BOX 80G', '6161106614462', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:07:03'),
(437, 5, 'DETREX ALOE VERA 80G', '6161106614578', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:11:44'),
(438, 5, 'SAWA ROSE BATHING SOAP 225G', '6161106610723', 'C128', NULL, 75.00, 90.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:00:04'),
(439, 5, 'SAWA HERBAL BATHING SOAP 225G', '6161106610716', 'C128', NULL, 75.00, 90.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:01:34'),
(440, 5, 'SAWA ORIGINAL BUBBLE GUM 225G', '6161106614868', 'C128', NULL, 75.00, 90.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:05:08'),
(441, 5, 'ERIPRIDE SCOURING POWDER 500G', 'PD0442', NULL, NULL, 100.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(442, 5, 'ERIPRIDE SCOURING POWDER 1KG', 'PD0443', NULL, NULL, 130.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(443, 1, 'PEMBE MAIZE MEAL 1KG', '6009627050003', 'C128', NULL, 65.00, 75.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:16:47'),
(444, 6, 'AMARA BODY GLYCERINE 100ML', '6161100043619', 'C128', NULL, 80.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:11:50'),
(445, 3, 'CADBURY DRINKING CHOCOLATE 125G', '7622210304537', 'C128', NULL, 132.00, 175.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:21:20'),
(446, 3, 'CADBURY COCOA POWDER 90G', '7622210304100', 'C128', NULL, 195.00, 235.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:38:25'),
(447, 1, 'AJAB MAIZE MEAL 2KG', 'PD0448', NULL, NULL, 129.00, 145.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(448, 12, 'TUZO LONG LIFE MILK 250ML', '6161101680271', 'C128', NULL, 38.00, 45.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:22:32'),
(449, 1, 'CHEVDA ', 'PD0450', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(450, 1, 'NIBZ CORN PUFFS', 'PD0451', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(451, 1, 'PRESTIGE MARGARINE 250G', '6161101668293', 'C128', NULL, 92.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:58:12'),
(452, 1, 'SUPA LOAF WHITE BREAD 800G', '6161102320183', 'C128', -1, 120.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:49:52'),
(453, 1, 'GARDEN PEANUT BUTTER 150G', 'PD0454', NULL, NULL, 90.00, 110.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(454, 1, 'GARDEN PEANUT BUTTER 250G', 'PD0455', NULL, NULL, 150.00, 170.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(455, 1, 'GARDEN HONEY 200G', 'PD0456', NULL, NULL, 125.00, 145.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(456, 1, 'GARDEN HONEY 100G', 'PD0457', NULL, NULL, 80.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(457, 6, 'VASELINE MEN COOLING 45ML', '61614123', 'C128', NULL, 50.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 00:47:56'),
(458, 7, 'COLGATE HERBAL 140G', '6920354817823', 'C128', NULL, 255.00, 300.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:08:25'),
(459, 7, 'KANGAROO METHYLATED SPIRIT  300ML', 'PD0460', NULL, NULL, 50.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(460, 7, 'OPTZAH METHYLATED SPIRIT 500ML', 'PD0461', NULL, NULL, 70.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(461, 9, 'PARTY CUP TUMBLER', 'PD0462', NULL, NULL, 5.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(462, 7, 'GILLETTE 2+ RAZOR', 'PD0463', NULL, NULL, 82.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(463, 2, 'WATHSAPP SWEET', 'PD0464', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(464, 2, 'JUICY FRUIT 4PELLETS', 'PD0465', 'C128', NULL, 6.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:15:05'),
(465, 2, 'FRESH SWEET', 'PD0466', NULL, NULL, 4.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(466, 1, 'DUNIA MAIZE MEAL 2KG', 'PD0467', NULL, NULL, 170.00, 190.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(467, 1, 'NDOVU MAIZE MEAL 2KG', 'PD0468', NULL, NULL, 125.00, 140.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(468, 3, 'NESCAFE CLASSIC 50G', 'PD0469', NULL, NULL, 338.00, 360.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(469, 1, 'SOKO PURE WIMBI 500G', 'PD0470', NULL, NULL, 70.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(470, 4, 'ALWAYS 3 IN 1 BLUE 7 PADS', '8001841720937', 'C128', NULL, 100.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:46:54'),
(471, 10, 'TOSS  GREEN 500G', 'PD0472', NULL, NULL, 158.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(472, 10, 'DAIRY JOY MILK', '6161100100190', 'C128', -1, 27.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:22:44'),
(473, 1, 'FAMILA UJIMIX SOUR 500G', '6161100450127', 'C128', NULL, 76.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:03:45'),
(474, 2, 'FRESH COOL FRUITY', 'PD0475', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(475, 2, 'NIBBZ', 'PD0476', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(476, 7, 'TWO HILL UPSCALE CLIPPER SERIES', 'PD0477', NULL, NULL, 20.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(477, 2, 'GOMBA BUBBLE GUM', 'PD0478', NULL, NULL, 1.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(478, 8, 'STREPSILS REGULAR MEDCINE', '6161100954229', 'C128', NULL, 13.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:27:47'),
(479, 5, 'BLUE BAND ORIGINAL SATCHET 30G', 'PD0480', NULL, NULL, 16.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(480, 7, 'NICE AND LOVELY COCOA BUTTER 400ML', '6161110963501', 'C128', NULL, 220.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:17:50'),
(481, 1, 'SUGAR', 'PD0482', NULL, NULL, 70.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(482, 1, 'SUKARI   1/4kg', 'PD0483', NULL, NULL, 32.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(483, 1, 'SUKARI 1KG', 'PD0484', NULL, NULL, 129.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(484, 1, 'BIRYAN RICE 1 KG', 'PD0485', NULL, NULL, 122.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(485, 2, 'NUMBERS', 'PD0486', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(486, 7, 'SUNLIGHT 80G', '6161100604261', 'C128', NULL, 29.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:04:01'),
(487, 4, 'SOFTCARE DIAPERS LARGE 8PCS', '6166000121917', 'C128', NULL, 130.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 21:12:17'),
(488, 3, 'AFIA MIXED FRUIT 500ML', '6008459000972', 'C128', -1, 63.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:50:54'),
(489, 3, 'PREDATOR MANGO MAYHEM ENERGY DRINK 400ML', 'PD0490', NULL, NULL, 54.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(490, 6, 'MOVIT OLIVE & ARGAN OIL SHEEN HAIR SPRAY 250ML', '6162400124602', 'C128', NULL, 280.00, 330.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:39:20'),
(491, 6, 'OLIVE OIL SHEEN SPRAY 85ML', '6291069732474', 'C128', NULL, 150.00, 200.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:43:45'),
(492, 6, 'BABYCARE JELLY 200G', 'PD0493', NULL, NULL, 90.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(493, 7, 'VIGOR DOCTOR HERBAL 100G', '6920790020139', 'C128', NULL, 70.00, 100.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:26:20'),
(494, 6, 'TROPICAL COCONUT OIL 150ML', '6009610390000', 'C128', NULL, 140.00, 170.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:42:00'),
(495, 6, 'TROPICAL COCONUT OIL 65ML', 'PD0496', NULL, NULL, 70.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(496, 6, 'THREE OIL SHEEN SPRAY 85ML', 'PD0497', NULL, NULL, 150.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(497, 5, 'DETTOL ANTISEPTIC LIQUID 50ML', '6161100950139', 'C128', NULL, 90.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:41:58'),
(498, 2, 'AMIGOS CORN CHIPS 20G', '6009626890310', 'C128', NULL, 8.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:33:38'),
(499, 2, 'AMERU COATED PEANUTS 60G', 'PD0500', NULL, NULL, 20.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(500, 2, 'AMERU COATED PEANUTS 20G', '6164003851206', 'C128', -5, 8.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 16:24:30'),
(501, 2, 'THE MASTER CAKE SWEET MAHAMRI 180GM', 'PD0502', NULL, NULL, 45.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(502, 3, 'CADBURY DRINKING 20G', '7622210304506', 'C128', NULL, 12.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:19:55'),
(503, 1, 'BROADWAYS WHITE BREAD 400G', '6166000001721', 'C128', -1, 61.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:04:24'),
(504, 1, 'RINA 500ML', 'PD0505', NULL, NULL, 142.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(505, 1, 'KNORR CHILLI BEEF CUBE PACKET', 'PD0506', NULL, NULL, 90.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(506, 1, 'KNORR CHILLI CUBE ', 'PD0507', NULL, NULL, 15.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(507, 3, 'LEMONADE LIME 300ML', '6164001199331', 'C128', NULL, 35.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:50:27'),
(508, 7, 'NEPTUNE TOILET PAPER 4 ROLLS PURPLE', '6161101661089', 'C128', NULL, 130.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:17:46'),
(509, 4, 'NEPTUNE TOILET PAPER 4 ROLLS GREEN', 'PD0510', NULL, NULL, 130.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(510, 4, 'PEACOCK JUMBO TOILET ROLL', 'PD0511', NULL, NULL, 80.00, 110.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(511, 5, 'MENENGAI BLACK SOAP 125g', '6161100903111', 'C128', NULL, 40.00, 60.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:14:04'),
(512, 5, 'MENENGAI GOLD SOAP 125g', 'PD0513', NULL, NULL, 40.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(513, 5, 'MILELE MILK SOAP 125g', '6161117772373', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:51:00'),
(514, 5, 'MILELE ALOE SOAP 250g', '6161117772403', 'C128', NULL, 70.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:57:05'),
(515, 5, 'LANZO LUXURY SOAP 100gm', 'PD0516', NULL, NULL, 40.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(516, 5, 'LANZO ANTI-BACTERIAL SOAP 100g', '6161101662352', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:46:44'),
(517, 5, 'LANZO COCONUT SOAP 100g', '6161101662314', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:41:32'),
(518, 1, 'BROADWAYS WHITE BREAD 200G', 'PD0519', NULL, NULL, 28.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(519, 1, 'JOGOO MAIZE MEAL 1KG', 'PD0520', NULL, NULL, 107.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(520, 1, 'EXE SELF RISING 2KG', 'PD0521', NULL, NULL, 203.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(521, 1, 'EXE MANDAZI WHEAT FLOUR 2KG', 'PD0522', NULL, NULL, 201.00, 215.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(522, 1, 'JOGOO 1KG', 'PD0523', NULL, NULL, 100.00, 110.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(523, 10, 'KCC MALA  HARD COVER 500ML', 'PD0524', NULL, NULL, 85.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(524, 1, 'BROADWAYS BROWN 400G', '6166000001738', 'C128', -1, 61.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:19:49'),
(525, 10, 'KCC MA,LA 500ML', '6161100461598', 'C128', -1, 70.00, 75.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 01:43:53'),
(526, 10, 'TUZO MAZIWA LALA 500ML', '6161107150396', 'C128', NULL, 70.00, 75.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:01:13'),
(527, 10, 'MALA  SMOOTH AND TASTY 200ML', 'PD0528', NULL, NULL, 30.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(528, 7, 'DOVE COTTON WOOL 100G', '6161102570014', 'C128', NULL, 70.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:04:25'),
(529, 7, 'VALVEX SUPER ABSOBENT COTTON WOOL 50G', 'PD0530', NULL, NULL, 40.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(530, 7, 'WINDMILL BUBBLE WATER', 'PD0531', NULL, NULL, 13.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(531, 1, 'P.K 2 PELLETS SWEET', 'PD0532', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(532, 2, 'JUICY FRUIT 2 PELLETS SWEET', 'PD0533', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(533, 1, 'PEPTANG TOMATO SAUCE 250G', '6161101061131', 'C128', NULL, 62.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:42:19'),
(534, 7, 'HANAN COTTON BUDS 100PCS', '6164000242427', 'C128', NULL, 100.00, 150.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:26:31'),
(535, 3, 'BARAKA CHAI 15G', '6161101860444', 'C128', NULL, 7.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:39:29'),
(536, 3, 'BARAKA CHAI TANGAWIZI 15G', '6161101860475', 'C128', NULL, 7.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:40:13'),
(537, 5, 'SUNLIGHT POWDER 200G YELLOW', 'PD0538', NULL, NULL, 62.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(538, 5, 'ARIEL POWDER 200G 1WASH', 'PD0539', NULL, NULL, 76.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(539, 7, 'BELLA WIPES', '6161114908751', 'C128', NULL, 130.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:35:32'),
(540, 7, 'DETTOL ORIGINAL 90G', '6161100952591', 'C128', -1, 130.00, 150.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:12:22'),
(541, 7, 'ZURI PARADISE SOAP 100G', '6161100902428', 'C128', -5, 35.00, 60.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 23:28:53'),
(542, 7, 'ZURI HERBAL SOAP 100G', 'PD0543', NULL, NULL, 40.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(543, 6, 'VESTLINE GARLIC HAND & BODY CREAM 200G', '6201100033941', 'C128', NULL, 60.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:16:20'),
(544, 6, 'SLEEPING BABY 100G', '6161104040157', 'C128', NULL, 60.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:35:18'),
(545, 6, 'GIRL FRIEND HONEY TWIST BODY LOTION 500ML', 'PD0546', NULL, NULL, 160.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(546, 6, 'GIRL FRIEND COCOA BUTTER  500ML', 'PD0547', NULL, NULL, 200.00, 240.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(547, 6, 'NIVEA MEN SILVER PROTECT 50ML', 'PD0548', NULL, NULL, 320.00, 400.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(548, 6, 'NIVEA MEN DRY IMPACT 50ML', '42299783', 'C128', NULL, 320.00, 400.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 19:20:43'),
(549, 6, 'NIVEA MEN DEEP BLACK CARBON 48H 50ML', 'PD0550', NULL, NULL, 320.00, 400.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(550, 6, 'GIRL FRIEND VANITY 50ML', '60094230', 'C128', NULL, 140.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 19:22:53'),
(551, 6, 'GIRL FRIEND SPIRIT 50ML', '60058997', 'C128', NULL, 140.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 19:24:01'),
(552, 6, 'GIRL FRIEND EMERALD ROLL-ON DEODORANT 50ML', 'PD0553', NULL, NULL, 140.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(553, 6, 'REXONA COTTON DRY 48H 25 ML', '4800888182166', 'C128', NULL, 140.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 16:04:14'),
(554, 6, 'REXONA MEN QUANTUM DRY 25ML', '4800888182111', 'C128', NULL, 140.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 16:02:48'),
(555, 6, 'REXONA MEN ACTIVE DRY 25ML', '4800888182142', 'C128', NULL, 140.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 16:01:48'),
(556, 6, 'VASELINE  COCOA BUTTER JELLY 240ML', '6161115171833', 'C128', NULL, 220.00, 300.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 00:39:07'),
(557, 6, 'VASELINE ORIGINAL JELLY 240ML', '6161115171857', 'C128', NULL, 220.00, 300.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:04:33'),
(558, 6, 'VASELINE MEN COOLING 240ML', '6161115171888', 'C128', NULL, 220.00, 300.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:01:42'),
(559, 1, 'JOGOO 2KG', 'PD0560', NULL, NULL, 200.00, 210.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(560, 1, 'HOSTESS 2KG', 'PD0561', NULL, NULL, 220.00, 240.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(561, 2, 'HIGH ENERGY BISCUITS HONEY & CHOCOLATE 70G', '6161101250382', 'C128', NULL, 16.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:38:55'),
(562, 2, 'THE REAL DIGESTIVE HIGH FIBRE BISCUITS 100G', '6161101251761', 'C128', NULL, 61.00, 95.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:44:40'),
(563, 1, 'KINGSMILL BREAD 200G', '6161103150703', 'C128', -1, 30.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:07:59'),
(564, 1, 'KINGSMILL BREAD 400G', '6161103150970', 'C128', NULL, 60.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 14:50:26'),
(565, 3, 'KABARNET MINERAL WATER 1 LITRE', 'PD0566', NULL, NULL, 44.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(566, 3, 'KABARNET MINERAL WATER 500ML', 'PD0567', NULL, NULL, 25.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(567, 2, 'SUNVEAT TEA BISCUITS 100G', '6164002740457', 'C128', NULL, 18.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:45:30'),
(568, 2, 'SO NICE COCONUT BISCUITS 100G', '6161101251853', 'C128', NULL, 38.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:46:20'),
(569, 1, 'EXE CHAPATI 2KG', 'PD0570', NULL, NULL, 196.00, 210.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(570, 1, 'EXE ATTA MARK 1 2KG', 'PD0571', NULL, NULL, 202.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(571, 5, 'OMO 75G', '6161115174766', 'C128', NULL, 18.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:48:31'),
(572, 7, 'NAIL CLIPPER', 'PD0573', NULL, NULL, 25.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(573, 11, 'CRAYONS', 'PD0574', NULL, NULL, 18.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(574, 7, 'MSAFI  WHITE WASHING POWDER LAVENDER FRESH 500G', '6161117772069', 'C128', -1, 114.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 16:15:03'),
(575, 7, 'MSAFI WHITE WASHING POWDER 500G', 'PD0576', NULL, NULL, 114.00, 140.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(576, 7, 'BIG BOSS WASHING BAR SOAP 1KG', '6164004999037', 'C128', NULL, 150.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:53:21'),
(577, 7, 'JAMAA CREAM WASHING BAR SOAP 800G', 'PD0578', NULL, NULL, 150.00, 195.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(578, 7, 'FRESH MULTPURPOSE WASHING BAR SOAP 1KG', 'PD0579', NULL, NULL, 150.00, 195.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(579, 7, 'SUMO HEAVY DUTY PEGS', '6161110883458', 'C128', NULL, 135.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 21:47:05'),
(580, 5, 'JIK REGULAR 70ML', '6161100950825', 'C128', NULL, 26.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:39:33'),
(581, 11, 'PLATINUM PENCILS HB', '6135647271606', 'C128', NULL, 8.00, 15.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:53:36'),
(582, 5, 'KIBUYU WHITE WASHING BAR SOAP 200G', '6161100907935', 'C128', NULL, 35.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:34:58'),
(583, 7, 'TEEPEE SHOE BRUSH', 'PD0584', NULL, NULL, 22.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(584, 4, 'ROSY  EXTRA STRONG TISSUE', '6161100762411', 'C128', -1, 32.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 02:38:39'),
(585, 4, 'PRENCESS SOFT WHITE TISSUE', 'PD0586', NULL, NULL, 16.00, 25.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(586, 4, 'PEACOCK NAFUU TOILET PAPER TISSUE', '6161101532051', 'C128', NULL, 16.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:07:17'),
(587, 2, 'FLOWER PICTURE LOLLIPOP', 'PD0588', NULL, NULL, 7.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(588, 7, 'NEPTUNE TOILET PEPAR 1 ROLL', 'PD0589', NULL, NULL, 34.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(589, 7, 'AIROMA FLORAL BLOOM AIR FRESHNER', 'PD0590', NULL, NULL, 130.00, 190.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(590, 7, 'AIROMA COTTON BREEZE AIR FRESHENER 300 ML', 'PD0591', NULL, NULL, 130.00, 190.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(591, 1, 'SOFTCARE BABY WIPES 80PCS', '6166000122167', 'C128', NULL, 139.00, 170.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:37:18'),
(592, 1, 'FACE TOWEL BIG', 'PD0593', NULL, NULL, 22.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(593, 4, 'FACE TOWEL SMALL', 'PD0594', NULL, NULL, 13.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(594, 7, 'LONG MANHATTAN HANKERCHIEF COTTON', 'PD0595', NULL, NULL, 33.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(595, 7, 'MEDIUM BALL', 'PD0596', NULL, NULL, 160.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(596, 7, 'BIG BALL', 'PD0597', NULL, NULL, 260.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(597, 7, 'UMBRELLA CURVED HANDLE', 'PD0598', NULL, NULL, 360.00, 500.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(598, 1, 'KHETIAS SUGAR 500G', 'PD0599', NULL, NULL, 83.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(599, 1, 'KHETIAS SUGAR 2KG', 'PD0600', NULL, NULL, 310.00, 410.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(600, 1, 'KHETIAS SUGAR 1KG', 'PD0601', NULL, NULL, 155.00, 210.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(601, 12, 'TORCH CHARGABLE', 'PD0602', NULL, NULL, 220.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(602, 2, 'BISCORITA CHOCO', 'PD0603', NULL, NULL, 7.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(603, 7, 'TEEPEE SCRUBBING BRUSH', '6161102260120', 'C128', NULL, 45.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 21:48:15'),
(604, 7, 'TEEPEE BLACK SMALL SHOE BRUSH ', 'PD0605', NULL, NULL, 50.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(605, 7, 'WHITEDENT FLUORIDE TOOTHPASTE HERBAL 132G', '6161101573351', 'C128', NULL, 120.00, 150.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:23:56'),
(606, 7, 'KAMBA(MANNILA)', 'PD0607', NULL, NULL, 70.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(607, 7, 'KAMBA SMALL', 'PD0608', NULL, NULL, 13.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(608, 7, 'JAMAA WHITE WASHING BAR 800G', 'PD0609', NULL, NULL, 150.00, 195.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(609, 1, 'TWO TEN HOME BAKING FLOUR 2KG', '6164000726149', 'C128', NULL, 170.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:25:41'),
(610, 1, 'TWO TEN SIFTED MAIZE MEAL 2KG', '6164000726170', 'C128', -1, 125.00, 145.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 16:30:54'),
(611, 6, 'AVVIS LONG ANGEL BRAID 1 ', 'PD0612', NULL, NULL, 63.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(612, 6, 'AVVIS  SHORT ANGEL BRAID 133', 'PD0613', NULL, NULL, 63.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(613, 6, 'AVVIS SHORT ANGEL BRAID 27', 'PD0614', NULL, NULL, 63.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(614, 6, 'AVVIS LONG ANGEL BRAID 33', 'PD0615', NULL, NULL, 63.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(615, 6, 'AVVIS SHORT ANGEL BRAID 30', 'PD0616', NULL, NULL, 63.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(616, 6, 'AVVIS SHORT ANGEL BRAID 133', 'PD0617', NULL, NULL, 63.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(617, 6, 'AVVIS LONG ANGEL BRAID 27', 'PD0618', NULL, NULL, 63.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(618, 6, 'AVVIS SHORT ANGEL BRAIDS 33', 'PD0619', NULL, NULL, 63.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(619, 6, 'AVVIS SHORT ANGEL BRAID 1', 'PD0620', NULL, NULL, 63.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(620, 7, 'MENENGAI VELVET BATHING BAR SOAP 125G', 'PD0621', NULL, NULL, 40.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(621, 8, 'PANADOL ADVANCE', 'PD0622', NULL, NULL, 6.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(622, 10, 'DAIRY JOY MILK ', 'PD0623', NULL, NULL, 27.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(623, 2, 'GOLD COIN', 'PD0624', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(624, 3, 'COCACOLA 500ML', 'PD0625', NULL, NULL, 40.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(625, 6, 'JIBAMBE SHORT BRAIDS 1', 'PD0626', NULL, NULL, 53.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(626, 6, 'JIBAMBE LONG BRAIDS', 'PD0627', NULL, NULL, 53.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(627, 1, 'JASIRI MAIZE MEAL', 'PD0628', NULL, NULL, 202.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(628, 3, 'LUCOZADE ENERGY 250ML', '61603011', 'C128', NULL, 70.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:16:07'),
(629, 1, 'YELLOW BEANS 1KG', 'PD0630', NULL, NULL, 144.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(630, 1, 'KAMANDE  CEREALS 1 KG', 'PD0631', NULL, NULL, 234.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(631, 1, 'WAIRIMU 1KG', 'PD0632', NULL, NULL, 162.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(632, 1, 'YELLOW BEANS 1/2 KG', 'PD0633', NULL, NULL, 72.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(633, 1, 'WAIRIMU 1/2 KG', 'PD0634', NULL, NULL, 81.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(634, 1, 'KAMANDE 1/2KG', 'PD0635', NULL, NULL, 117.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(635, 2, 'RICH MADEIRA 280G', 'PD0636', NULL, NULL, 72.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(636, 2, 'JUNIOR DELI 300G', '792382560912', 'C128', NULL, 76.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:35:32'),
(637, 2, 'LITTLE HEART 150G', 'PD0638', NULL, NULL, 46.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(638, 2, 'TWIN DELI 150G', 'PD0639', NULL, NULL, 46.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(639, 2, 'SAWA MUFFIN  6PCS 300G', '792382560936', 'C128', -1, 106.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:52:06'),
(640, 2, 'SAWA MUFFIN 4PK  200G', 'PD0641', NULL, NULL, 72.00, 85.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(641, 2, 'QUEEN CAKE 6PCS 260G', '792382560950', 'C128', -2, 78.00, 95.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:15:06'),
(642, 2, 'QUEEN CAKE 8PCS 200G', '792382565467', 'C128', -1, 67.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:15:06'),
(643, 2, 'MANDAZI BITES 180G', 'PD0644', NULL, NULL, 41.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(644, 2, 'CHOCO MUFFIN 6PCS 300G', 'PD0645', NULL, NULL, 106.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(645, 7, 'PEKEE POA UNWRAPPED 10 ROLLS', '6761100164569', 'C128', NULL, 145.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:27:02'),
(646, 1, 'COSMO FORTIFIED SIFTED MAIZE MEAL 2KG', 'PD0647', NULL, NULL, 204.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(647, 4, 'ALWAYS 3 IN 1 LIGHT BLUE', '4015400671336', 'C128', NULL, 98.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:40:49'),
(648, 1, 'NDEGU 1/4 KG', 'PD0649', NULL, NULL, 35.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(649, 1, 'YELLOW BEANS 1/4 KG', 'PD0650', NULL, NULL, 36.00, 75.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(650, 1, 'KAMANDE 1/4 KG', 'PD0651', NULL, NULL, 59.00, 75.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(651, 1, 'WAIRIMU 1/4', 'PD0652', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(652, 1, 'TWO TEN  SIFTED MAIZE MEAL 500G', 'PD0653', NULL, NULL, 46.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(653, 1, 'AJAB HOME BAKING 500 G', '6161113940127', 'C128', NULL, 47.00, 55.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:12:00'),
(654, 1, 'AJAB FORTIFIED ALL PURPOSE 500 G', 'PD0655', NULL, NULL, 48.00, 55.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(655, 1, 'TAR MAKARON SPAGHETT', '6260100311114', 'C128', NULL, 110.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:54:59'),
(656, 7, 'SOFT VIVY WHITE TOILET 10 ROLLS', 'PD0657', NULL, NULL, 150.00, 170.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(657, 7, 'LIVELLE KITCHEN TOWEL 1 ROLL', 'PD0658', NULL, NULL, 150.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(658, 7, 'SAWA ROSE BATH SOAP 70G', '6161106611744', 'C128', NULL, 25.00, 50.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 19:59:02'),
(659, 7, 'SAWA ORIGINAL 70G', '6161106611737', 'C128', NULL, 25.00, 50.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:09:52'),
(660, 5, 'DETREX GERM PROTECTION SOAP 100G', '6161106612611', 'C128', NULL, 40.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:09:53'),
(661, 2, 'ICE CREAM MARSHMALLOW CANDY', 'PD0662', NULL, NULL, 0.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(662, 2, 'TRUFFES CHOCOLATE', 'PD0663', NULL, NULL, 0.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(663, 2, 'CHOCOLATEE CANDY', 'PD0664', NULL, NULL, 5.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(664, 2, 'SHAPES LOLLIPOP', 'PD0665', NULL, NULL, 0.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(665, 2, 'ELVAN COMPOUND CHOCOLATE', 'PD0666', NULL, NULL, 0.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(666, 2, 'SIMSIM NJUGU KARANGA ', 'PD0667', NULL, NULL, 0.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(667, 7, 'TOOTHPICK', 'PD0668', NULL, NULL, 0.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(668, 5, 'ERICA BLOSSOM  LEMON FRESH DISH WASHING LIGUID 500ML', 'PD0669', NULL, NULL, 0.00, 170.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(669, 1, 'SWAN UNGA SAFI MAHINDI 2KG', 'PD0670', NULL, NULL, 204.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(670, 1, 'SHEREHE FORTIFIED MAIZE MEAL 2KG', 'PD0671', NULL, NULL, 192.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(671, 1, 'POPCORN 1 KG', 'PD0672', NULL, NULL, 171.00, 320.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(672, 1, 'POPCORN 1/2 KG', 'PD0673', NULL, NULL, 86.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(673, 1, 'POPCORN 1/4KG', 'PD0674', NULL, NULL, 43.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(674, 1, 'NJUGU KARANGA 1KG', 'PD0675', NULL, NULL, 211.00, 240.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(675, 1, 'NJUGU KARANGA 1/2 KG', 'PD0676', NULL, NULL, 106.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(676, 1, 'NJUGU KARANGA 1/4 KG', 'PD0677', NULL, NULL, 53.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(677, 2, 'JUNIOR MADEIRA 350G', 'PD0678', NULL, NULL, 95.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(678, 1, 'YAMI BREAD 200G', '745125277950', 'C128', NULL, 32.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:58:57'),
(679, 1, 'YAMI BREAD 400G', '745760153886', 'C128', NULL, 60.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 14:47:30'),
(680, 1, 'MENENGAI BLACK SOAP 200G', '6161100903128', 'C128', NULL, 60.00, 80.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:18:31'),
(681, 5, 'MENENGAI GOLD SOAP 200G', '6161100902732', 'C128', NULL, 60.00, 80.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:17:38'),
(682, 9, 'JIBAMBE APPLE 250 ML', '6164000242168', 'C128', NULL, 46.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:21:18'),
(683, 7, 'TENNIS BALL', 'PD0684', NULL, NULL, 0.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(684, 7, 'VELVEX SUPER COTTON WOOL 200 G', '6161100761445', 'C128', NULL, 0.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:09:41'),
(685, 3, 'EPIC FRESH DRINKING WATER 500ML', 'PD0686', NULL, NULL, 14.00, 25.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(686, 3, 'EPIC FRESH DRINKING WATER 1 LITER', '745604079990', 'C128', NULL, 0.00, 0.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:32:45'),
(687, 11, 'PREMIUN PENCILS', 'PD0688', NULL, NULL, 0.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(688, 7, 'HANAN PREMIUM TISSUE', '6164000242403', 'C128', NULL, 40.00, 55.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:58:25'),
(689, 2, 'DOUGHNUTS CAKES  600G', 'PD0690', NULL, -1, 50.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 02:38:39'),
(690, 1, 'DAAWAT TRADITIONAL BASMATI RICE 1 KG', '6161103940076', 'C128', NULL, 296.00, 380.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:59:52'),
(691, 1, 'FRESH FRY 1 LITERS', 'PD0692', NULL, NULL, 294.00, 400.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(692, 7, 'ARIEL FRESH SPRING 70G', '8700216288811', 'C128', NULL, 27.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:26:18'),
(693, 7, 'TOILEX WHITE TOILET 2 ROLLS', 'PD0694', NULL, NULL, 69.00, 85.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(694, 7, 'BELLA WHITE 2 ROLLS', '6164000242540', 'C128', -1, 62.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:01:22');
INSERT INTO `products` (`id`, `category_id`, `product_name`, `product_code`, `product_barcode_symbology`, `product_quantity`, `product_cost`, `product_price`, `wholesale_price`, `product_unit`, `product_stock_alert`, `product_order_tax`, `product_tax_type`, `product_note`, `supplier_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(695, 2, 'PK GREEN 10 PELLETS', '6161115860201', 'C128', NULL, 15.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:35:31'),
(696, 2, 'PK BLUE 10 PELLETS', 'PD0697', NULL, NULL, 0.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(697, 3, 'JUO ORANGE FLAVOURED DRINK 300ML', 'PD0698', NULL, NULL, 25.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(698, 3, 'JUO PASSION  FLAVOURED DRINK 300 ML', 'PD0699', NULL, NULL, 25.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(699, 3, 'SAVANAH ORANGE 2 LITERS', 'PD0700', NULL, NULL, 281.00, 320.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(700, 1, 'BIRYAN 1/4 KG', 'PD0701', NULL, NULL, 31.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(701, 1, 'PISHORI 1/4KG', 'PD0702', NULL, NULL, 36.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(702, 1, 'SANTA MARIA SPAGHETTI 400G', '6164004818406', 'C128', NULL, 126.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:55:35'),
(703, 1, 'DUNIA FORTIFIED MAIZE MEAL 1KG', 'PD0704', NULL, NULL, 104.00, 115.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(704, 1, 'FAMILA BABY WEANING 500G', 'PD0705', NULL, NULL, 79.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(705, 5, 'KLEESOFT 200G', 'PD0706', NULL, NULL, 32.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(706, 2, 'TWIST  CHOCOLATE CREAM BISCUIT', '6223000418956', 'C128', NULL, 23.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:19:49'),
(707, 2, 'ENERGY BISCUITS 40 G', 'PD0708', NULL, NULL, 10.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(708, 2, 'MILK ENERGY BISCUITS', 'PD0709', NULL, NULL, 10.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(709, 7, 'DETTOL SOAP ORIGINAL 60G', 'PD0710', NULL, NULL, 90.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(710, 3, 'RIBENA BLACKCURRANT FLAVOURED DRINK 500ML', 'PD0711', NULL, NULL, 40.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(711, 5, 'WATER AQUAGUARD 150ML', '6166005111029', 'C128', NULL, 29.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:27:44'),
(712, 4, 'SOFTCARE DIAPERS XL NO.6', 'PD0713', NULL, NULL, 17.00, 25.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(713, 5, 'EZEE DISH WASHING GEL 500ML', '6161103015170', 'C128', NULL, 200.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:29:15'),
(714, 5, 'SPARK FRESH METHYLATED SPIRIT  300ML', 'PD0715', NULL, NULL, 50.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(715, 2, 'LEASHERMATT SCONES CAKES', 'PD0716', NULL, NULL, 50.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(716, 4, 'MOLFIX NO4 40PCS', '6224008817598', 'C128', NULL, 560.00, 650.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 21:39:45'),
(717, 2, 'FAB CHOCOLATE 25G', '8901719904769', 'C128', NULL, 18.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:30:21'),
(718, 2, 'P.K GREEN 5 PELLETS', 'PD0719', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(719, 2, 'TROPICAL SWEETS', 'PD0720', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(720, 2, 'BIG G ORIGINAL CHEWING GUM', 'PD0721', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(721, 10, 'MAX CHOCO DRINKING CHOCOLATE', 'PD0722', NULL, NULL, 4.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(722, 10, 'MAX CHOCO DRINKING CHOCOLATE 20G', 'PD0723', NULL, NULL, 8.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(723, 4, 'GUPPIES PREMIUM DIAPERS MEDIUM', 'PD0724', NULL, NULL, 11.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(724, 10, 'ZENA LONG MILK 500ML', 'PD0725', NULL, NULL, 51.00, 55.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(725, 9, 'SCOURING BRITE SPONGE ', 'PD0726', NULL, NULL, 26.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(726, 1, 'EGG TRAY ', 'PD0727', NULL, NULL, 410.00, 450.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(727, 1, 'ZESTA RED PLUM JAM 100G', '6162000010015', 'C128', -1, 51.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 01:35:15'),
(728, 3, 'ILARA YOGHURT VANILLA FLAVOUR 500G', '6161101000895', 'C128', NULL, 109.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:07:26'),
(729, 1, 'BLUE BAND LOW FAT SPREAD 500G', 'PD0730', NULL, NULL, 215.00, 270.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(730, 3, 'ACACIA MANGO KIDS DRINK 200ML', '6161110811291', 'C128', NULL, 35.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:54:27'),
(731, 2, 'NALA INSTANT NOODLES 120 G', 'PD0732', NULL, NULL, 36.00, 45.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(732, 3, 'CHAMP ORANGE JUICE 150 ML', 'PD0733', NULL, NULL, 14.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(733, 2, 'SUNFRESH TOMATO SAUCE 250G', 'PD0734', NULL, NULL, 38.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(734, 1, 'DOLA PREMIUM MAIZE FLOUR 2 KG', 'PD0735', NULL, NULL, 212.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(735, 3, 'STONEY 300ML', 'PD0736', NULL, NULL, 65.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(736, 6, 'FIANCEE MOISTURISING LOTION 400ML', 'PD0737', NULL, NULL, 120.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(737, 6, 'SHEA BUTTER LOTION 400 ML', 'PD0738', NULL, NULL, 120.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(738, 6, 'OUD LUXURY LOTION 400ML', 'PD0739', NULL, NULL, 120.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(739, 6, 'SKALA ALOEVERA BODY LOTION 400ML', '6201100032739', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:22:54'),
(740, 6, 'AFROCARE MULTI-ACTIVE LOTION 400ML', 'PD0741', NULL, NULL, 120.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(741, 6, 'SKALA FOR MEN 400ML', '6201100033446', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:23:21'),
(742, 7, 'TENA POCKET TISSUES 10 SHEETS', 'PD0743', NULL, NULL, 20.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(743, 7, 'VELVEX POCKET TISSUE 10 SHEETS', 'PD0744', NULL, NULL, 20.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(744, 7, 'KIWI 15ML/12G', '61602212', 'C128', -1, 43.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:15:11'),
(745, 7, 'LUDE BLACK SHOE POLISH 40G/50ML', '6901997603912', 'C128', NULL, 75.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:49:26'),
(746, 7, 'LUDE BLACK SHOE POLISH 20 ML', 'PD0747', NULL, NULL, 35.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(747, 7, 'SLIPPERS ', 'PD0748', NULL, NULL, 120.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(748, 9, 'MUG CUP', 'PD0749', NULL, NULL, 83.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(749, 9, 'KNIFE', 'PD0750', NULL, NULL, 100.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(750, 9, 'THERMOS FLASK', 'PD0751', NULL, NULL, 350.00, 500.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(751, 9, 'SPOON', 'PD0752', NULL, NULL, 8.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(752, 9, 'TEASPOON', 'PD0753', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(753, 9, 'OASIS PLATE', 'PD0754', NULL, NULL, 91.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(754, 9, 'OASIS PLATES FLOWERS', 'PD0755', NULL, NULL, 100.00, 140.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(755, 1, 'PAKSTAN RICE 1KG', 'PD0756', NULL, NULL, 0.00, 170.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(756, 1, 'PAKSTAN RICE 1/2KG', 'PD0757', NULL, NULL, 0.00, 85.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(757, 3, 'DELMONTE MIXED BERRIES 1 LITER', '024000150138', 'C128', NULL, 255.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:59:21'),
(758, 3, 'DELMONTE PASSION FRUIT 1 LITRE', '024000191667', 'C128', NULL, 255.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:03:39'),
(759, 3, 'DELMONTE APPLE JUICE 1 LITRE', '024000150053', 'C128', NULL, 255.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:02:49'),
(760, 1, 'BB WHITE BREAD 400G', '6164004213010', 'C128', NULL, 60.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 14:46:55'),
(761, 2, 'MID DELI', 'PD0762', NULL, NULL, 150.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(762, 2, 'MID MADEIRA 500G', 'PD0763', NULL, NULL, 152.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(763, 11, 'OBAMA SMOOTHLINE PEN', 'PD0764', NULL, NULL, 7.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(764, 2, 'PK BLUE', 'PD0765', NULL, -5, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:27:50'),
(765, 2, 'PK GREEN', 'PD0766', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(766, 2, 'RUBBER ERASERS', 'PD0767', NULL, NULL, 6.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(767, 2, 'TAMU TAMU GREEN', 'PD0768', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(768, 1, 'KENSAFI TOMATO PASTE 50G', 'PD0769', NULL, NULL, 9.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(769, 7, 'GILLETTE 7 OCLOCK RAZORBLADE', 'PD0770', NULL, NULL, 2.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(770, 1, 'KIFARU SIFTED MAIZE MEAL 2KG', 'PD0771', NULL, NULL, 181.00, 155.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(771, 1, 'HODI SIFTED MAIZE MEAL 2KG', 'PD0772', NULL, NULL, 197.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(772, 1, 'NDHIWA WHITE SUGAR 2 KG', 'PD0773', NULL, NULL, 420.00, 450.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(773, 3, 'QUENCHER JUNIOR 150ML', 'PD0774', NULL, NULL, 15.00, 25.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(774, 2, 'NJUGU KARANGA#2', 'PD0775', NULL, NULL, 10.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(775, 2, 'NJUGU KARANGA#1', 'PD0776', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(776, 1, 'FINE WHITE  BREAD 400G', 'PD0777', NULL, NULL, 60.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(777, 1, 'FINE WHITE BREAD 200G', 'PD0778', NULL, NULL, 33.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(778, 1, 'NDEGU 1/4KG', 'PD0779', NULL, NULL, 32.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(779, 1, 'MID DELI 500G', 'PD0780', NULL, NULL, 148.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(780, 1, 'MID MEDEIRA 500G', 'PD0781', NULL, NULL, 148.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(781, 1, 'HANAN ALUMIUM FOIL', '6164002695856', 'C128', -1, 93.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:48:09'),
(782, 2, 'YEGO MARIE BISCUITS', 'PD0783', NULL, NULL, 95.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(783, 2, 'YEGO CHAI BISCUITS 100G', '6161114908683', 'C128', NULL, 33.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:39:39'),
(784, 2, 'YEGO ENERGY BISCUITS 60G', '6161114908898', 'C128', NULL, 22.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:36:18'),
(785, 2, 'YEGO MARIE TEA BISCUITS 60G', 'PD0786', NULL, NULL, 18.00, 25.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(786, 2, 'YEGO SHUJAA BISCUITS', 'PD0787', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(787, 7, 'BELLA WHITE TISSUE 4 ROLLS', '6164000242557', 'C128', NULL, 127.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:18:18'),
(788, 7, 'BELLA WHITE JUNIOR TISSUE', '6161114909758', 'C128', NULL, 23.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:59:43'),
(789, 7, 'COLGATE MAXIMUM CAVITY PROTECTION 35G', '6001067040149', 'C128', NULL, 62.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:09:24'),
(790, 12, 'EVEREADY RED AAA', 'PD0791', NULL, NULL, 51.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(791, 12, 'EVEREADY RED AA', 'PD0792', NULL, NULL, 51.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(792, 1, 'TOTO AFYA 500G', 'PD0793', 'C128', NULL, 125.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:48:45'),
(793, 2, 'X-FRESH CHEWING GUM 14G', 'PD0794', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(794, 2, 'MR TATTOO PINEAPPLE ', 'PD0795', NULL, NULL, 4.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(795, 2, 'CHOCOLATE ICECREAM', 'PD0796', NULL, NULL, 13.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(796, 2, 'CAR MOBILIZATION CHOCOLATE BISCUITS', 'PD0797', NULL, NULL, 13.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(797, 2, 'TOOFROOTY TOFFEE', 'PD0798', NULL, NULL, 4.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(798, 2, 'GOMBA SPECIAL', '6161103031965', 'C128', NULL, 3.00, 5.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:39:19'),
(799, 2, 'RAMINA WAFERS', 'PD0800', NULL, NULL, 7.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(800, 2, 'CHOCOLATE CON GALLETA', 'PD0801', NULL, NULL, 1.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(801, 2, 'MABUYU', 'PD0802', NULL, NULL, 7.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(802, 2, 'BATOOK SPECIALMINT  CHEWING GUM', 'PD0803', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(803, 3, 'SANTA MARIA SOY SAUCE DARK', '6164004454932', 'C128', NULL, 118.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:23:30'),
(804, 1, 'NDHIWA WHITE SUGAR 1KG', 'PD0805', NULL, NULL, 225.00, 245.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(805, 1, 'TWO TEN SIFTED MAIZE MEAL 1KG', 'PD0806', NULL, NULL, 63.00, 75.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(806, 11, 'KASUKU A4 200 PGS RULED', '6161101536790', 'C128', NULL, 85.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:15:52'),
(807, 6, 'TCB  HAIR SHEEN SPRAY 250ML', '3863847007390', 'C128', NULL, 300.00, 350.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:40:13'),
(808, 6, 'RADIANT LEAVE-IN TREATMENT 300ML', '6161107222024', 'C128', NULL, 290.00, 340.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:41:19'),
(809, 6, 'RADIANT LEAVE-IN TREATMENT 100ML', '6161107222055', 'C128', NULL, 120.00, 150.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:40:42'),
(810, 6, 'AL-REHAB CROWN PERFUME FOR MEN 50ML', 'PD0811', NULL, NULL, 230.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(811, 6, 'AL-REHAB INSPIRATION PERFUME', 'PD0812', NULL, NULL, 230.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(812, 6, 'AL-REHAB RAYAN BLACK PERFUME 50ML', 'PD0813', NULL, NULL, 230.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(813, 6, 'AL-REHAB SABAYA PERFUMES 50ML', 'PD0814', NULL, NULL, 230.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(814, 6, 'AL-REHAB LORD PERFUME', 'PD0815', NULL, NULL, 230.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(815, 6, 'AL-REHAB SUPERMAN PERFUME 50ML', 'PD0816', NULL, NULL, 230.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(816, 6, 'TROPICAL COCONUT OIL ALISON 65ML', '6164000066207', 'C128', NULL, 80.00, 100.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:36:57'),
(817, 6, 'NATURALLY FAIR 25ML', '8901248411233', 'C128', NULL, 80.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 19:47:49'),
(818, 6, 'EVEN & LOVELY 25ML', 'PD0819', NULL, NULL, 75.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(819, 6, 'GOLD NORMAL SKIN CREAM 25ML', '6161110962481', 'C128', NULL, 85.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 19:54:54'),
(820, 6, 'BABY SOFT PURE  150ML', '6161101577977', 'C128', NULL, 65.00, 85.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:44:46'),
(821, 6, 'SOFTY CARROT CREAM 200ML', '6203015930209', 'C128', NULL, 80.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:57:23'),
(822, 6, 'BAMSI HAIR FERTILIZER 50G', '6164000838415', 'C128', NULL, 45.00, 75.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:04:00'),
(823, 6, 'VENUS CURL ACTIVATOR  GEL 100ML', '6161102002492', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:40:05'),
(824, 6, 'MOVIT HAIR FOOD 70G', '6164000613418', 'C128', NULL, 80.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:01:05'),
(825, 6, 'MOVIT STYLING HAIR GEL 150G', '6161107220242', 'C128', NULL, 140.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:00:23'),
(826, 6, 'TCB NATURAL HAIR FOOD 100ML', '6161100884311', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:40:57'),
(827, 6, 'NIVEA NOURISHING COCOA LOTION 100ML', '4005900792679', 'C128', NULL, 180.00, 220.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:21:16'),
(828, 6, 'NIVEA RICH NOURISHING 100ML', 'PD0829', NULL, NULL, 180.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(829, 6, 'NIVEA SHEA SMOOTH LOTION 100ML', 'PD0830', NULL, NULL, 180.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(830, 6, 'NIVEA MEN COOL KICK LOTION 100ML', 'PD0831', NULL, NULL, 180.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(831, 5, 'STA SOFT SPRING FRESH 750ML', 'PD0832', NULL, NULL, 300.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(832, 5, 'STASOFT LAVENDER FRESH 750ML', 'PD0833', NULL, NULL, 300.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(833, 2, 'POPCORNS', 'PD0834', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(834, 2, 'POPCORNS SNACKS PACKED', 'PD0835', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(835, 2, 'JUICY COLLA', 'PD0836', NULL, NULL, 2.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(836, 2, 'JOIFA SOYA 50G', '6164003825016', 'C128', NULL, 20.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:52:35'),
(837, 7, 'SPIDERMAN BALLS', 'PD0838', NULL, NULL, 30.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(838, 7, 'CLING FILM WRAPPING & STORING 15metres', 'PD0839', NULL, NULL, 120.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(839, 7, 'STATWRAP CLING FILM WRAPPING & STORING ', 'PD0840', NULL, NULL, 0.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(840, 2, 'PIPES SNACKS', 'PD0841', NULL, NULL, 4.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(841, 10, 'MOUNT KENYA PREMIUM MILK 500ML', 'PD0842', NULL, NULL, 56.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(842, 5, 'PRIDE LEMON FRESH LIQUID DETERGENT 500ML', 'PD0843', NULL, NULL, 150.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(843, 1, 'SELECTA SOFT BREAD 400G', 'PD0844', NULL, NULL, 55.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(844, 2, 'FRUITY BUNCH CHOCOLATE 12G', 'PD0845', NULL, NULL, 13.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(845, 2, 'SHORT CAKE BISCUITS', 'PD0846', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(846, 3, 'SMASH PINEAPPLE FLAVOURED DRINK 200ML', 'PD0847', NULL, NULL, 11.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(847, 3, 'SMASH ORANGE FLAVOURED DRINK 200ML', 'PD0848', NULL, NULL, 11.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(848, 3, 'SMASH MANGO FLAVOURED DRINK 200ML', 'PD0849', NULL, NULL, 11.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(849, 2, 'GRANDE MADEIRA 750G', '792382560868', 'C128', NULL, 178.00, 220.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:36:03'),
(850, 2, 'GRANDE DELI 750G', 'PD0851', NULL, NULL, 178.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(851, 7, 'CARRIER BAG BIG#3', 'PD0852', NULL, NULL, 20.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(852, 7, 'CARRIER BAG SMALL#3', 'PD0853', NULL, NULL, 20.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(853, 7, 'CARRIER BAG BIG #3', 'PD0854', NULL, NULL, 30.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(854, 1, 'COCONUT MILK 400ML', '8805001014009', 'C128', NULL, 158.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:44:03'),
(855, 1, 'COCONUT CREAM 400ML', '8858554000692', 'C128', NULL, 210.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:45:16'),
(856, 3, 'CADBURY DRINKING CHOCOLATE 225G', '7622210304544', 'C128', NULL, 287.00, 325.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:20:35'),
(857, 1, 'PEPTANG HOT & SWEET SAUCE 420G', '09821514', 'C128', NULL, 113.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:39:24'),
(858, 1, 'ZESTA TOMATO SAUCE 400G', '6162000020014', 'C128', -1, 82.00, 100.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 01:43:53'),
(859, 1, 'FRESH FRY 5LITERS', 'PD0860', NULL, NULL, 1192.00, 1400.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(860, 7, 'POSHY ROLL XTRA TISSUE', '710535837377', 'C128', NULL, 27.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:02:01'),
(861, 3, 'RED BULL ENERGY DRINK 250ML', '90162602', 'C128', NULL, 180.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:21:54'),
(862, 3, 'NESCAFE 3 IN 1CREAMY WHITE 18G', '6161106962532', 'C128', NULL, 21.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:22:14'),
(863, 2, 'SAFARI PUFFS BARBEQUE 12G', '6161100916487', 'C128', NULL, 6.00, 10.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:26:45'),
(864, 5, 'USHINDI LEMON DISHWASHING PASTE 200G', 'PD0865', NULL, NULL, 58.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(865, 7, 'MOSQUITO COILS  GREEN COILS', 'PD0866', NULL, NULL, 35.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(866, 7, 'MOSQUITO COIL RED COILS', 'PD0867', NULL, NULL, 5.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(867, 7, 'TROPICAL HEAT TURMERIC SPICE 50G', '6161100913080', 'C128', NULL, 75.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:02:33'),
(868, 6, 'PURE COCONUT OIL 150ML', 'PD0869', NULL, NULL, 0.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(869, 7, 'PURE COCONUT OIL 80ML', 'PD0870', NULL, NULL, 0.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(870, 2, 'CADBURY DAIRY MILK 35G', '7622201508524', 'C128', NULL, 25.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:59:17'),
(871, 1, 'SPECIAL SINDANO RICE 1KG', 'PD0872', NULL, NULL, 144.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(872, 1, 'SPECIAL SINDANO 1/2 KG', 'PD0873', NULL, NULL, 68.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(873, 3, 'GOFRUT MULTI-FRUIT 1LITRE', '6161104405239', 'C128', NULL, 131.00, 170.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:14:18'),
(874, 3, 'SUNTOP ORANGE 125ML', '6162008400009', 'C128', NULL, 21.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:35:53'),
(875, 9, 'KNIFE (FRUIT KNIFE)', 'PD0876', NULL, NULL, 45.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(876, 2, 'BRITANNIA MILK BIKIS 40G', 'PD0877', NULL, NULL, 14.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(877, 2, 'BRITANNIA  HIGH-FIBRE DIGESTIVE BISCUIT 40G', '6291007913958', 'C128', NULL, 14.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:46:59'),
(878, 4, 'HANDKERCHIEF  XIANG PAI', 'PD0879', NULL, NULL, 60.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(879, 4, 'HANDKERCHIEF XIANG PAI COTTON', 'PD0880', NULL, NULL, 80.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(880, 3, 'KERICHO GOLD TEA BAG #25 BAGS', '6161101860017', 'C128', NULL, 80.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:18:19'),
(881, 3, 'KERICHO GOLD TEA  #50 TEA BAGS', '6161101860024', 'C128', NULL, 130.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:18:54'),
(882, 7, 'BELLA JUMBO  ROLL', '6164000242595', 'C128', NULL, 129.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:23:18'),
(883, 1, 'NUT GOLD PEANUT BUTTER 500G', '6164000242069', 'C128', NULL, 280.00, 350.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:03:35'),
(884, 1, 'NUT GOLD PEANUT BUTTER 250G', 'PD0885', NULL, NULL, 190.00, 240.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(885, 2, 'YEGO SHORT CAKE BISCUITS 100G', 'PD0886', NULL, NULL, 21.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(886, 2, 'YEGO FAMILY BISCUITS 32G', 'PD0887', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(887, 2, 'MAHJONG CHOCOLATE +COOKIES', 'PD0888', NULL, NULL, 13.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(888, 2, 'TOPNUTS PEANUT BUTTER 15G', '4040000012258', 'C128', NULL, 8.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:57:56'),
(889, 7, 'PEPSODENT TOOTHBRUSH MEDIUM', '6164004675382', 'C128', NULL, 35.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:36:57'),
(890, 7, 'PEPSODENT HERBAL  FLUORIDE TOOTHPASTE 65G', 'PD0891', NULL, NULL, 70.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(891, 9, 'USHINDI LEMON DISHWASHING PASTE 400G', '6161106613120', 'C128', NULL, 153.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:54:26'),
(892, 3, 'QUENCHER ORANGE 1 LITRE', 'PD0893', NULL, NULL, 157.00, 190.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(893, 2, 'MIL TOMATO SAUCE 250ML', 'PD0894', NULL, NULL, 28.00, 45.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(894, 2, 'EXECUTIVE TOMATO SAUCE 400ML', '6164000204432', 'C128', NULL, 34.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:55:16'),
(895, 1, 'SUNRICE BASMATI RICE 1KG', '6164000512018', 'C128', NULL, 279.00, 350.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:01:39'),
(896, 1, 'PURE MWEA PISHORI GRADE 1 1KG', 'PD0897', NULL, NULL, 233.00, 290.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(897, 3, 'HIKAYA MANGO JUICE 200ML', 'PD0898', NULL, NULL, 29.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(898, 1, 'PASTARICCO MAKARONI 500G', '8690946350837', 'C128', NULL, 104.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:57:56'),
(899, 1, 'CROWN BIRYANI LONG GRAIN RICE 1KG', 'PD0900', NULL, NULL, 180.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(900, 1, 'PEARL GREEN GRAMS 500G', '6161102170481', 'C128', NULL, 86.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:59:07'),
(901, 1, 'PEARL GREEN GRAMS 1KG', '6161102170382', 'C128', NULL, 185.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:58:37'),
(902, 4, 'KOTEX TAMPON SUPER', '5029053534817', 'C128', NULL, 320.00, 360.00, NULL, 'PIECES', 5, 5, NULL, NULL, 1, NULL, NULL, '2024-06-20 20:15:13'),
(903, 4, 'SOFTCARE SANITARY PADS PETAL CARE', 'PD0904', NULL, NULL, 58.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(904, 2, 'MILO NESTLE 10G', '6161106961757', 'C128', NULL, 17.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:21:14'),
(905, 12, 'OSRAM CLASSIC A  75W', 'PD0906', NULL, NULL, 0.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(906, 12, 'AVC LED BULB 10W', 'PD0907', NULL, NULL, 0.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(907, 4, 'ALLORA PANTY LINER (20 LINERS)', 'PD0908', NULL, NULL, 135.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(908, 8, 'KALUMA KING HERBAL', 'PD0909', NULL, NULL, 15.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(909, 8, 'KALUMA PAIN BALM', 'PD0910', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(910, 8, 'MENTHO PLUS BALM', 'PD0911', NULL, NULL, 45.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(911, 9, 'SCOURING PAD SUPERBRITE', 'PD0912', NULL, NULL, 48.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(912, 7, 'POLYESTER THREAD', 'PD0913', NULL, NULL, 15.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(913, 5, 'MOSQUITO REPELLENT WOODY(RED)', 'PD0914', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(914, 7, 'INCENSE STICKS WOODY(BLACK)', 'PD0915', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(915, 11, 'TAPE #SMALL', 'PD0916', NULL, NULL, 0.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(916, 11, 'TAPE #BIG', 'PD0917', NULL, NULL, 0.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(917, 3, 'DORMANS INSTANT COFFEE 2G', '6161100860155', 'C128', NULL, 7.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:37:16'),
(918, 3, 'DORMANS IRISH CREAM COFFEE (3 IN 1)18G', '6161100861992', 'C128', NULL, 22.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:36:02'),
(919, 12, 'EXTENSION SOCKET CABLE(POWER KING)', 'PD0920', NULL, NULL, 0.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(920, 12, '25 W AFRILIGHTING LED BULB', 'PD0921', NULL, NULL, 0.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(921, 7, 'FACE TOWEL#', 'PD0922', NULL, NULL, 0.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(922, 11, 'A4 DOCUMENT ENVELOPE', 'PD0923', NULL, NULL, 7.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(923, 9, 'KICHUNGI', 'PD0924', NULL, NULL, 10.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(924, 6, 'CROCHET HOOKS NO.7', 'PD0925', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(925, 11, 'A5 ENVELOPE ', 'PD0926', NULL, NULL, 4.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(926, 9, 'HARD STEELWOOL', 'PD0927', NULL, NULL, 10.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(927, 7, 'CANDLE', 'PD0928', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(928, 3, 'KREST 300ML', 'PD0929', NULL, NULL, 29.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(929, 1, 'KAMILA SOUR FLOUR 400G', 'PD0930', 'C128', NULL, 35.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:06:52'),
(930, 2, 'MINI HEART 150G(MILL BAKERS)', 'PD0931', NULL, NULL, 55.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(931, 2, 'DAZ BITE LEMON 180G(MILL BAKERS)', 'PD0932', NULL, NULL, 45.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(932, 2, 'WHITE BUNS 350G(MILL BAKERS)', 'PD0933', NULL, NULL, 60.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(933, 2, 'HEART DELI 300ML(MILL BAKERS)', 'PD0934', NULL, NULL, 90.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(934, 2, 'CRUFFINS 300G(MILL BAKERS)', 'PD0935', NULL, NULL, 60.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(935, 6, 'ROBIN THREAD', 'PD0936', NULL, NULL, 50.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(936, 6, 'BEULA GOLD SHAMPOO 250ML', 'PD0937', NULL, NULL, 100.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(937, 2, ' EXPLODE BUBBLE GUM', 'PD0938', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(938, 2, 'TOFIBOL MR BERRY', 'PD0939', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(939, 7, 'HANAN CLING FILM', '6164002695979', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:39:19'),
(940, 2, 'JUICY FRUIT 10 PELLETS', '6161115860157', 'C128', NULL, 19.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:16:40'),
(941, 3, 'JOIFA COFFEE 25G', '6164003825030', 'C128', NULL, 23.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:51:11'),
(942, 7, 'WATER BOTTLES (STALLION)', 'PD0943', NULL, NULL, 60.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(943, 7, 'WATER BOTTLES (ROK) 500ML', 'PD0944', NULL, NULL, 50.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(944, 3, 'FRUIT PARADISE(ORANGE) 250ML', 'PD0945', NULL, NULL, 48.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(945, 3, 'TUNDA FRUIT DRINK (APPLE)', 'PD0946', NULL, NULL, 46.00, 55.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(946, 7, 'COLGATE CHARCOAL 120G', '8718951350885', 'C128', NULL, 270.00, 330.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:03:19'),
(947, 7, 'ZURI HERBAL SOAP 200G', '6161100902497', 'C128', NULL, 65.00, 90.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 03:04:00'),
(948, 6, 'IDEAL OLIVE OIL 50ML', '6009610390215', 'C128', NULL, 140.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:56:46'),
(949, 6, 'IDEAL OLIVE OIL 25ML', '6164000066313', 'C128', NULL, 80.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:58:31'),
(950, 3, 'DELMONTE APPLE 250ML', '024000102601', 'C128', NULL, 66.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:17:41'),
(951, 3, 'MINUTE MAID LEMONADE 280ML', 'PD0952', NULL, NULL, 41.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(952, 3, 'HIGHLANDS MANGO CORDIAL 2 LITRES', '6161102051667', 'C128', NULL, 317.00, 360.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:31:17'),
(953, 7, 'SUNLIGHT  HANDWASH 500G', 'PD0954', NULL, NULL, 177.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(954, 12, 'TOCEBAL BATTERY AAA', 'PD0955', NULL, NULL, 30.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(955, 9, 'DELISH  LUNCH BOX', 'PD0956', NULL, NULL, 47.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(956, 7, 'TOILET  BRUSH ROUND BOWL SET', 'PD0957', NULL, NULL, 110.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(957, 7, 'TOILET LAVATORY BRUSH', 'PD0958', NULL, NULL, 140.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(958, 11, 'A5  GRAPH BOOK 48PGS', 'PD0959', NULL, NULL, 21.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(959, 11, 'KASUKU A5 GRAPH BOOK 96PGS', '6161101537117', 'C128', NULL, 30.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:46:43'),
(960, 7, 'JUMBOFLOOR MOP', 'PD0961', NULL, NULL, 230.00, 270.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(961, 7, 'MEDIUMFLOOR MOP', 'PD0962', NULL, NULL, 150.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(962, 7, 'MEDIUM FLOOR MOP', '6161102260229', 'C128', NULL, 150.00, 200.00, NULL, 'PIECES', 5, 5, NULL, NULL, 1, NULL, NULL, '2024-06-20 21:51:02'),
(963, 7, 'TEEPEE SCRUBBING BRUSH', '6161102262308', 'C128', NULL, 35.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 21:52:57'),
(964, 7, 'BLACK BRUSH ', 'PD0965', NULL, NULL, 35.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(965, 7, 'HARD  SCRUBBING A1P BRUSH', 'PD0966', NULL, NULL, 70.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(966, 5, 'DETTOL  ANTI-BACTERIAL ORIGINAL  SOAP 90G', '6161100952', 'C128', -1, 130.00, 150.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:16:04'),
(967, 9, 'SEWING PLASTIC DISH', 'PD0968', NULL, NULL, 20.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(968, 5, 'STASOFT  LAVENDERFRESH 400ML', 'PD0969', NULL, NULL, 190.00, 230.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(969, 5, 'STASOFT   SPRING FRESH 400ML', 'PD0970', NULL, NULL, 190.00, 230.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(970, 7, 'BIC RAZOR  1', '6161100040007', 'C128', NULL, 23.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:28:46'),
(971, 2, 'COOKIES', 'PD0972', NULL, NULL, 50.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(972, 11, 'HACO SCHOOL  RULER', 'PD0973', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(973, 3, 'LUCOZADE   ENERGY  DRINK  BOTTLE 500ML', 'PD0974', NULL, NULL, 200.00, 250.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(974, 3, 'RIBENA BLACKCURRANT 500ML', '6164003477161', 'C128', NULL, 270.00, 320.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:13:36'),
(975, 1, 'GARLIC POWDER SPICE 50G', '6161100912281', 'C128', NULL, 82.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:59:17'),
(976, 1, 'BLACK PEPPER  SPICE 50G', '6161100911192', 'C128', NULL, 109.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:01:21'),
(977, 1, 'CINNAMON  (CASSIA) SPICE 50G', '6161100911598', 'C128', NULL, 86.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:03:36'),
(978, 1, 'CARDAMONS SPICE 50G', '6161100911291', 'C128', NULL, 200.00, 240.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:58:50'),
(979, 1, 'GINGER SPICE  50G', '6161100912380', 'C128', NULL, 68.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:03:04'),
(980, 2, 'FOOD COLOUR EGG YELLOW', 'PD0981', NULL, NULL, 8.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(981, 6, 'VASELINE BABY PERFUMED JELLY 45 ML', '61614154', 'C128', -1, 65.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 02:38:39'),
(982, 6, 'BAMSI  STYLING HAIR JEL 80G', '745240426158', 'C128', NULL, 70.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:08:14'),
(983, 6, 'SOFRFREE STYLING GEL 125ML', '60024855', 'C128', NULL, 120.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:17:31'),
(984, 3, 'DELMONTE  MIXED   BERRIES JUICE BLEND 250 ML', 'PD0985', NULL, NULL, 53.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(985, 3, 'DELMONTE ORANGE BLEND 250ML', '024000102519', 'C128', NULL, 53.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:19:34'),
(986, 3, 'DELMONTE APPLEJUICE 250ML', 'PD0987', NULL, NULL, 53.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(987, 3, 'DELMONTE  MANGO PINEAPPLE  JUICE  BLEND 250ML', 'PD0988', NULL, NULL, 53.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(988, 3, 'DELMONTE  TROPICAL1 LITRE', '024000150121', 'C128', NULL, 255.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:01:45'),
(989, 3, 'DELMONTE  PINEAPPLE 1LITRE', '024000224556', 'C128', NULL, 255.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:56:43'),
(990, 2, 'MILK  CANDY', 'PD0991', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(991, 9, 'XFRESH  DISH  WASHING  LIQUID 1LITRE', 'PD0992', NULL, NULL, 200.00, 250.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(992, 9, 'XFRESH  DISH WASHING LIQUID 500ML', 'PD0993', NULL, NULL, 105.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(993, 8, 'HITZZ  INSECT  KILLER  400ML', '6291104001541', 'C128', NULL, 230.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:13:44'),
(994, 8, 'FAMILY INSECT KILLER 400ml', '9556288049558', 'C128', NULL, 230.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:13:00'),
(995, 6, 'CLERE  WILD FLOWERS 400ML', '616762734512', 'C128', NULL, 180.00, 210.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:25:01'),
(996, 6, 'CLERE  NATURAL OLIVE  400ML', '6001374018473', 'C128', NULL, 180.00, 210.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:26:27'),
(997, 6, 'CLERE  LANOLIN & GLYCERINE  400ML', '6001374033018', 'C128', NULL, 180.00, 210.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:23:56'),
(998, 6, 'CLERE  LANOLIN & GLYCERINE  200ML', '60062901', 'C128', NULL, 110.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:28:02'),
(999, 6, 'CLERE  NATURAL OLIVE 200ML', '6001374018497', 'C128', NULL, 110.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:31:00'),
(1000, 6, 'CLERE  COCOA  BUTTER  200ML', '60062932', 'C128', NULL, 110.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:27:25'),
(1001, 6, 'VASELINE  BABY PERFUMED PETROLEUM JELLY 95 ML', 'PD1002', NULL, NULL, 110.00, 140.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, '2024-06-21 00:53:43', NULL, '2024-06-21 00:53:43'),
(1002, 10, 'GOLD  CROWN MILK 500ML', 'PD1003', NULL, NULL, 57.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1003, 10, 'MOUNT KENYA YOGHURT STRAWBERRY 250ML', 'PD1004', NULL, NULL, 50.00, 55.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1004, 10, 'MOUNT  KENYA YOGHURT  VANILLA  250ML', 'PD1005', NULL, NULL, 50.00, 55.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1005, 2, 'NUVITA  TEA BISCUITS', 'PD1006', NULL, NULL, 8.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1006, 2, 'NUVITA  SPONGE CAKE VANNILA', '6161103945903', 'C128', NULL, 7.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:16:07'),
(1007, 7, 'HANAN  ALUMINIUM FOIL 45CM*90M', 'PD1008', NULL, NULL, 1600.00, 1800.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1008, 1, 'INDOMIE 5 PACK', 'PD1009', NULL, NULL, 118.00, 140.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1009, 1, 'INDOMIE 5 PACK  CHICKEN FLAVOUR', '5285000390640', 'C128', NULL, 118.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:34:06'),
(1010, 1, 'MODERN TOAST WHITE BREAD  400G', 'PD1011', NULL, NULL, 60.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1011, 1, 'MODERN TOAST WHITE BREAD 200G', 'PD1012', NULL, NULL, 33.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1012, 6, 'BEULA GOLD LEMONADE SHAMPOO', 'PD1013', NULL, NULL, 100.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1013, 6, 'BEULA GOLD CREAM CONDITIONER 500ML', '6164004648508', 'C128', NULL, 100.00, 150.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 03:00:10'),
(1014, 7, 'HERI WHITE TISSUE', 'PD1015', NULL, NULL, 14.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1015, 7, 'ZURI  JUMBO  ROLL', 'PD1016', NULL, NULL, 58.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1016, 11, 'LUMINOUS PAPER', 'PD1017', NULL, NULL, 40.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1017, 11, 'MANNILA  PAPER', 'PD1018', NULL, NULL, 20.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1018, 1, 'PEPTANG  CHILI  SAUCE  140G', '6008835000473', 'C128', NULL, 50.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:44:02'),
(1019, 1, 'PEPTANG PURE  HONEY 500G', 'PD1020', NULL, NULL, 365.00, 400.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1020, 1, 'PEPTANG PURE  HONEY 300G', 'PD1021', NULL, NULL, 235.00, 280.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1021, 10, 'LATO MILK 125ML', '6164002812628', 'C128', -1, 20.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 16:13:56'),
(1022, 1, 'KINYARA  SUGAR 2KG', 'PD1023', NULL, NULL, 435.00, 460.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1023, 1, 'NUTRA MEAL SUGAR 1KG', 'PD1024', NULL, NULL, 218.00, 245.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1024, 1, 'SUPA LOAF 600G', '6161102320169', 'C128', NULL, 90.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:14:27'),
(1025, 11, 'PERMANENT  MARKER PEN', 'PD1026', NULL, NULL, 10.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1026, 7, 'KIDS  SHOOT  GUN', 'PD1027', NULL, NULL, 14.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1027, 7, 'BAIDA LIGHTER', 'PD1028', NULL, NULL, 12.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1028, 2, 'PARLE-G BISCUITS', 'PD1029', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1029, 2, 'NUVITA BREAKTIME TEA', 'PD1030', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1030, 2, 'FOOD COLOUR ORANGE', 'PD1031', NULL, NULL, 8.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1031, 7, 'ROLINSON TOP SECURITY  LOCKS', 'PD1032', NULL, NULL, 190.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1032, 7, 'MINDY  ANTI-THEFT LOCK', 'PD1033', NULL, NULL, 500.00, 850.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1033, 7, 'MINDY   ANTI-THEFT  LOCK', 'PD1034', NULL, NULL, 520.00, 1000.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1034, 7, 'AUDDY  SAFETY PADLOCK 60MM', 'PD1035', NULL, NULL, 270.00, 500.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1035, 7, 'ROLINSON  TOP SECURITY LOCK 50MM', 'PD1036', NULL, NULL, 160.00, 280.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1036, 7, 'AUDDY SAFETY PADLOCK 50MM', 'PD1037', NULL, NULL, 220.00, 400.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1037, 7, 'STELAR PADLOCK  60MM    ', 'PD1038', NULL, NULL, 260.00, 400.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1038, 7, 'STELAR   PADLOCK 50MM', 'PD1039', NULL, NULL, 200.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1039, 7, 'STELAR  PADLOCK  40MM', 'PD1040', NULL, NULL, 180.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1040, 7, 'NAIL CLIPPER  MAXOWELL', 'PD1041', NULL, NULL, 15.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1041, 4, 'SOFTCARE DIAPER LARGE 40PCS', '6166000121832', 'C128', NULL, 608.00, 690.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 21:17:05'),
(1042, 2, 'DECOR HEART 400G', 'PD1043', NULL, NULL, 180.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1043, 2, 'DARLING CAKE 150G', 'PD1044', NULL, NULL, 45.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1044, 2, 'BREAKFAST  CAKE 150G', 'PD1045', NULL, NULL, 60.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1045, 4, 'SOFTCARE DIAPER SMALL 48PCS', '6166000121856', 'C128', NULL, 608.00, 690.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 21:18:15'),
(1046, 1, 'MTIBWA SUGAR1KG', 'PD1047', NULL, NULL, 0.00, 240.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1047, 7, 'PANDA TISSUE', 'PD1048', NULL, NULL, 350.00, 400.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1048, 7, 'BELLA WHITE TISSUE 10 ROLLS', '6164000242571', 'C128', NULL, 350.00, 400.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 01:56:29');
INSERT INTO `products` (`id`, `category_id`, `product_name`, `product_code`, `product_barcode_symbology`, `product_quantity`, `product_cost`, `product_price`, `wholesale_price`, `product_unit`, `product_stock_alert`, `product_order_tax`, `product_tax_type`, `product_note`, `supplier_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1049, 10, 'GOLD CROWN MILK 500ML', '6161100460102', 'C128', NULL, 59.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:24:59'),
(1050, 6, 'BEULA  GOLD EGG SHAMPOO 1LITRE', 'PD1051', NULL, NULL, 130.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1051, 6, 'BEULAGOLD PINK ROSE 1 LITRE', '6164004700053', 'C128', NULL, 130.00, 200.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 19:42:32'),
(1052, 2, 'JUNIOUR MANDAZI  BITES 100G', 'PD1053', NULL, NULL, 20.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1053, 1, 'SPECIAL SINDANO1/4', 'PD1054', NULL, NULL, 28.00, 45.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1054, 6, 'BAMSI WHITE NATURAL CONDITIONER 500ML', '6164000838781', 'C128', NULL, 80.00, 100.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:57:04'),
(1055, 6, 'ADORA  CRYSTAL SHAMPOO 500ML', 'PD1056', NULL, NULL, 80.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1056, 6, 'OLIVE OIL  SHAMPOO 500ML', 'PD1057', NULL, NULL, 80.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1057, 6, 'LELA NATURAL SHAMPOO 500ML', 'PD1058', NULL, NULL, 80.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1058, 6, 'ADORA OLIVE CONDITIONER 250ML', 'PD1059', NULL, NULL, 50.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1059, 6, 'LELA  NATURAL CONDITIONER  250ML', 'PD1060', NULL, NULL, 60.00, 85.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1060, 6, 'OLIVE OIL LELA SHAMPOO', 'PD1061', NULL, NULL, 60.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1061, 6, 'ADORA CRYSTAL SHAMPOO250ML', 'PD1062', NULL, NULL, 60.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1062, 6, 'BABY SOFT JELLY 250ML', '6161101570978', 'C128', NULL, 110.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:42:39'),
(1063, 10, 'BROOKSIDE SWEET LALA 1000G', '6161107151782', 'C128', NULL, 170.00, 185.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:54:15'),
(1064, 5, 'KLEESOFT  ANTI BACTERIAL 1KG', '6203012970802', 'C128', NULL, 150.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:10:22'),
(1065, 5, 'MSAFI WASHING POWDER WHITE 1KG', '6161107772246', 'C128', NULL, 210.00, 240.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:06:09'),
(1066, 1, 'RAHA PREMIUM  HOME BAKING FLOUR 2KG', 'PD1067', NULL, NULL, 173.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1067, 6, 'BEULA  ALMOND HAIR FOOD 500G', '6164004700411', 'C128', NULL, 250.00, 300.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:25:47'),
(1068, 6, 'BEULA GOLD  HANDWASH 300ML', 'PD1069', NULL, NULL, 130.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1069, 6, 'BEULA ALOE  PURE GLYCERINE 100ML', '6164004648720', 'C128', NULL, 95.00, 110.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 19:41:30'),
(1070, 6, 'BEULA  ALOE GLYCERINE 50ML', 'PD1071', NULL, NULL, 55.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1071, 6, 'BEULA GLYCERINE PINKROSE 30ML', 'PD1072', NULL, NULL, 35.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1072, 5, 'IMPERIAL LEATHER CLASSIC SOAP  75G', '6161102003673', 'C128', NULL, 45.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:23:47'),
(1073, 3, 'NOVIDA SCHWEPPES 350ML', 'PD1074', NULL, NULL, 45.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1074, 1, 'CROWN  BROWN SUGAR  1KG', 'PD1075', NULL, NULL, 115.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1075, 2, 'DELLISO WHITE CHOCOLATE  WAFER', '8697439302076', 'C128', NULL, 15.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:30:48'),
(1076, 2, 'PATCO SWEETS', 'PD1077', NULL, NULL, 1.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1077, 2, 'ZESTA TOMATO SAUCE 250G', '7167004049992', 'C128', NULL, 57.00, 85.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:52:19'),
(1078, 2, 'CADBURY DAIRY MILK 10G', '7622201508265', 'C128', NULL, 21.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:03:18'),
(1079, 2, 'DAIRY MILK HAZELNUT CADBURY 35G', '7622201510633', 'C128', NULL, 87.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:52:27'),
(1080, 2, 'DAIRY MILK FRUIT & NUT  CADBURY 35G', '7622201510756', 'C128', NULL, 87.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:04:32'),
(1081, 2, 'FUN  EGG  SHAPED CANDY', 'PD1082', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1082, 3, 'FRUTA JUICE ORANGE FLAVOUR 200ML', 'PD1083', NULL, NULL, 11.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1083, 1, 'CHOCO  PRIMO DRINKING 20G', 'PD1084', 'C128', NULL, 16.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:26:20'),
(1084, 1, 'ZESTA WHITE  VINEGAR 300ML', '6162000023114', 'C128', NULL, 42.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:16:55'),
(1085, 1, 'SOY  SAUCE  DARK SUPERIOR 150ML', 'PD1086', NULL, NULL, 127.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1086, 1, 'CIL PURE MWEA  PISHORI 1KG', '6161102170108', 'C128', NULL, 263.00, 350.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:00:23'),
(1087, 1, 'MACCOFFEE KENYAN KAHAWA', '8886300080018', 'C128', NULL, 38.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:53:23'),
(1088, 11, 'SUCCESS CARD BIG', 'PD1089', NULL, NULL, 80.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1089, 11, 'SUCCESS CARD SMALL', 'PD1090', NULL, NULL, 30.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1090, 10, 'BOGANI VANILLA FLAVOUR YOGHURT 150ML', 'PD1091', NULL, NULL, 55.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1091, 10, 'BOGANI STRAWBERRY FLAVOUR YOGHURT 150ML', 'PD1092', NULL, NULL, 55.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1092, 10, 'BOGANI  STRAWBERRY FLAVOUR YOGHURT  250ML', 'PD1093', NULL, NULL, 70.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1093, 10, 'BOGANI VANILLA  FLAVOUR YOGHURT', 'PD1094', NULL, NULL, 70.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1094, 10, 'MALA KCC 500ML TIN', 'PD1095', NULL, NULL, 85.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1095, 6, 'BEULA HAIR FOOD SWEET  ALMOND 500G', 'PD1096', NULL, NULL, 250.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1096, 10, 'DAIMA FLAVOURED MILK STRAWBERRY 250ML', 'PD1097', NULL, NULL, 52.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1097, 10, 'DAIMA MILK DRINK VANNILA 250ML', 'PD1098', NULL, NULL, 46.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1098, 10, 'DAIMA MILK DRINK STRAWBERRY 250 ML', '6164004562194', 'C128', NULL, 46.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:49:34'),
(1099, 3, 'BRAVA MANGO FRUIT  JUICE 300ML', '6164004075120', 'C128', -1, 38.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 01:33:09'),
(1100, 3, 'BRAVA  APPLE JUICE DRINK 300ML', '6164004075281', 'C128', NULL, 38.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:40:04'),
(1101, 5, 'DOWNY LUXURY 40ML', 'PD1102', NULL, NULL, 27.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1102, 5, 'DOWNY LUXURY PERFUME 40ML', 'PD1103', NULL, NULL, 27.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1103, 2, 'NUVITA BREAKTIME BISCUITS 100G', 'PD1104', NULL, NULL, 26.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1104, 2, 'PARLE MILK POWER CHOCO BISCUITS', 'PD1105', NULL, NULL, 17.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1105, 6, 'BALLET  MOSQUITO REPELLENT 50G', '6009617770102', 'C128', NULL, 90.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:02:18'),
(1106, 6, 'BALLET  MOSQUITO REPELLENT  SMALL 50G', 'PD1107', NULL, NULL, 90.00, 110.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1107, 6, 'BALLET MOSQUITO REPELLENT  BIG 100G', '6009617770119', 'C128', NULL, 180.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:03:07'),
(1108, 6, 'MOSQUITO REPELLANT  CREAM 70G', 'PD1109', NULL, NULL, 35.00, 45.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1109, 6, 'CUSSONS BABY PERFUMED 100ML', '6008879012340', 'C128', NULL, 130.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:37:04'),
(1110, 6, 'CUSSONS BABY PERFUMED 200ML', '6161102006841', 'C128', NULL, 240.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:40:37'),
(1111, 6, 'MEDIVEN CREAM 15G', 'PD1112', 'C128', NULL, 64.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 19:46:55'),
(1112, 3, 'DELMONTE PASSION PINEAPPLE 1LITRE', '024000224419', 'C128', NULL, 250.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:05:03'),
(1113, 2, 'MANDOLIN CADBURY 13.5G', '7622202023392', 'C128', NULL, 17.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:56:48'),
(1114, 6, 'BEULA GOLD BRAIDS N WEAVES 500G', '6161115200434', 'C128', NULL, 110.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:27:59'),
(1115, 5, 'ARIEL LIQUID DOWNY 40ML', 'PD1116', NULL, NULL, 11.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1116, 1, 'MACCOFFEE', 'PD1117', NULL, NULL, 3.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1117, 3, 'MINUTE MAID FRUITY BOOST 400ML', 'PD1118', NULL, NULL, 76.00, 95.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1118, 2, 'SOSSI CHUNKS SOYBEAN 80G', '6008155002294', 'C128', NULL, 30.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:30:15'),
(1119, 2, 'TREATOS MILK BISCUITS 105G', 'PD1120', NULL, NULL, 42.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1120, 2, 'PARLE TEA BISCUITS ', 'PD1121', NULL, NULL, 18.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1121, 1, 'PERBOILED RICE 1KG', 'PD1122', NULL, NULL, 152.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1122, 3, 'FRUIT PARADISE MANGO JUICE 1 LITRE', 'PD1123', NULL, NULL, 180.00, 210.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1123, 5, 'EZEE DISH WASHING PASTE 500G', '6161103015378', 'C128', NULL, 180.00, 240.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:13:38'),
(1124, 5, 'EZEE SCOURING POWDER 1KG', '6161103015262', 'C128', NULL, 135.00, 200.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:56:23'),
(1125, 7, 'COLGATE CHARCOAL 35G', '6920354837616', 'C128', NULL, 75.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:01:08'),
(1126, 4, 'LOVING IT AIRFRESHNER ORANGE 300ML', 'PD1127', NULL, NULL, 230.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1127, 2, 'NUVITA SPONGE STRAWBERRY CAKE 30G', '6161103945262', 'C128', NULL, 11.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:17:16'),
(1128, 7, 'TUSKYS WHITE CHOICE TOILET PAPER', 'PD1129', NULL, NULL, 15.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1129, 2, 'TREATOS GLUCOSE BISCUIT 50G', '6164004597974', 'C128', NULL, 18.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:36:49'),
(1130, 2, 'KINGTAT CHOCOLATE', '8693029034556', 'C128', NULL, 13.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:33:57'),
(1131, 2, 'TODAY  WAFER MILK CREAM', 'PD1132', NULL, NULL, 19.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1132, 2, 'TROPICAL FRUIT FLAVOURED CANDY', 'PD1133', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1133, 2, 'NATIONAL CHEWING GUM', 'PD1134', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1134, 2, 'SUPER TATOO BUBBLE GUM', 'PD1135', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1135, 2, 'MABUYUZ CHILLI BALL', 'PD1136', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1136, 7, 'GILLETTE  NACET STAINLESS', 'PD1137', NULL, NULL, 6.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1137, 7, 'GILLETTE  NACET STAINLESS RAZOR BLADE', 'PD1138', NULL, NULL, 6.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1138, 11, 'BIC CRISTAL BALL PEN ', 'PD1139', NULL, NULL, 17.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1139, 3, 'RIBENA BLACKCURRANT 1 LITRE', '6164003477079', 'C128', NULL, 475.00, 550.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:14:13'),
(1140, 1, 'POPCO COOKING OIL 3 LITRES', '6161106610310', 'C128', NULL, 708.00, 900.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:45:28'),
(1141, 1, 'PASTARICCO SPAGHETT 500G', 'PD1142', NULL, NULL, 102.00, 140.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1142, 5, 'VIM  LAVENDER CLEANER 1KG', '6162006608223', 'C128', NULL, 179.00, 240.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:41:20'),
(1143, 5, 'ARIEL FRESH LAVENDER CLEAN 70G', '8700216288804', 'C128', NULL, 27.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:23:48'),
(1144, 5, 'SUNLIGHT LAVENDER FRESH 80G', '6161115175008', 'C128', NULL, 27.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:42:50'),
(1145, 3, 'GLACIER WATER 500ML', 'PD1146', NULL, NULL, 15.00, 25.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1146, 3, 'JUNIOUR JUICE 125ML', 'PD1147', NULL, NULL, 25.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1147, 1, 'DARK VANILLA ESSRNCE 50ML', 'PD1148', NULL, NULL, 90.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1148, 5, 'USHINDI DISHWASHINGPASTE800G', '6161106613229', 'C128', NULL, 275.00, 300.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:48:28'),
(1149, 1, 'PEARL PISHORI RICE 1KG', '6161102170160', 'C128', NULL, 292.00, 340.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:00:51'),
(1150, 1, 'TROPICAL HEAT CURRY POWDER SPICE 10G', '6161100913240', 'C128', NULL, 15.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:27:33'),
(1151, 1, 'MARA BROWN SUGAR 1KG', 'PD1152', NULL, NULL, 217.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1152, 1, 'MARA BROWN SUGAR 2KG', 'PD1153', NULL, NULL, 290.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1153, 1, 'ZESTA MIXED FRUIT  JAM 300G', '6162000010329', 'C128', NULL, 157.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:12:48'),
(1154, 1, 'KINGSMILL BREAD 600G', 'PD1155', NULL, NULL, 120.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1155, 6, 'SUBARU HAIR COLORANT', '6951665460088', 'C128', NULL, 45.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 19:45:04'),
(1156, 1, 'MACCOFFEE WHITE  3 IN 1 15G', 'PD1157', NULL, NULL, 18.00, 25.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1157, 4, 'KOTEX ULTRA SANITARY PADS', '5029053569802', 'C128', NULL, 103.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:41:22'),
(1158, 8, 'ROYMEO METHYLATED SPIRIT 500ML', '792382437931', 'C128', NULL, 70.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:24:28'),
(1159, 12, 'INSULATING TAPE', 'PD1160', NULL, NULL, 20.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1160, 1, ' PERBOILED RICE 1KG', 'PD1161', NULL, NULL, 123.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1161, 1, 'PROBOILED RICE 1/2KG', 'PD1162', NULL, NULL, 62.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1162, 1, 'PROBOILED RICE 1/4KG', 'PD1163', NULL, NULL, 32.00, 45.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1163, 1, 'KENLON TOMATO PASTE 100G', 'PD1164', NULL, NULL, 59.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1164, 1, 'KENYLON TOMATO PASTE  275G', '6162000048889', 'C128', NULL, 162.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:42:08'),
(1165, 1, 'MAYONNAISE REGULAR 237ML', '757349228243', 'C128', NULL, 177.00, 220.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:13:25'),
(1166, 2, 'ACACIA HONEY 300G', 'PD1167', NULL, NULL, 243.00, 280.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1167, 5, 'USHINDI DISHWASHING LEMON 200G', '6161106613106', 'C128', NULL, 69.00, 100.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:51:03'),
(1168, 5, 'MORNING FRESH DISHWASHING PASTE 400G', 'PD1169', NULL, NULL, 250.00, 280.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1169, 5, 'PRIDE DISH WASHING LEMON 400G', '6161100881563', 'C128', NULL, 200.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:58:25'),
(1170, 6, 'FEATHER HAIR BAND', 'PD1171', NULL, NULL, 30.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1171, 6, 'USHANGA SMALL HAIR BAND', 'PD1172', NULL, NULL, 15.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1172, 6, 'USHANGA BIG HAIR BANDS', 'PD1173', NULL, NULL, 25.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1173, 6, 'HAIR BANDS BIG SIZE', 'PD1174', NULL, NULL, 25.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1174, 6, 'EVERLASTING FRENCH NAILS', 'PD1175', NULL, NULL, 25.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1175, 2, 'YEGO NICE BISCUITS 100G', '6164000242298', 'C128', NULL, 22.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:44:04'),
(1176, 2, 'YEGO CHAI BWAKU 32G', '6161114908386', 'C128', NULL, 9.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:48:52'),
(1177, 12, 'STELAR PADLOCK 70MM', 'PD1178', NULL, NULL, 300.00, 500.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1178, 12, 'ROLLISEN TOP SECURITY 60MM', 'PD1179', NULL, NULL, 190.00, 280.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1179, 12, 'ROLISON TOP SECURITY PADLOCK 70MM', 'PD1180', NULL, NULL, 210.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1180, 12, 'CICA TOP CYCLLE PADLOCK 50MM', 'PD1181', NULL, NULL, 280.00, 500.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1181, 12, 'YONGLI PADLOCK 266', 'PD1182', NULL, NULL, 140.00, 250.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1182, 12, 'YONGLI PADLOCK 265', 'PD1183', NULL, NULL, 85.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1183, 12, 'YONGLI PADLOCK 264', 'PD1184', NULL, NULL, 55.00, 170.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1184, 12, 'TRI-CYCLIC PADLOCK  265', 'PD1185', NULL, NULL, 90.00, 280.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1185, 12, 'TRI-CYCLIC PADLOCK  266', 'PD1186', NULL, NULL, 140.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1186, 12, 'TRI-CYCLIC PADLOCK 263', 'PD1187', NULL, NULL, 50.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1187, 12, 'HARD-CIRCLE PADLOCK 63mm', 'PD1188', NULL, NULL, 85.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1188, 2, 'KISMAT PEANUT FRIED  50G', 'PD1189', NULL, NULL, 28.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1189, 2, 'KISMAT PEANUT FRIED 200G', 'PD1190', NULL, NULL, 90.00, 115.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1190, 2, 'KISMAT PEANUT ROASTED 100G', 'PD1191', NULL, NULL, 53.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1191, 2, 'KISMAT PEANUT ROASTED 200G', 'PD1192', NULL, NULL, 104.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1192, 2, 'KISMAT  FRIED PEANUT 100G', 'PD1193', NULL, NULL, 46.00, 55.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1193, 2, 'KISMAT  MASALA PEANUT 100G', 'PD1194', NULL, NULL, 50.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1194, 2, 'KISMAT MASALA PEANUT 200G', 'PD1195', NULL, NULL, 55.00, 125.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1195, 2, 'KISMAT ROASTED PEANUT 50G', 'PD1196', NULL, NULL, 28.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1196, 2, 'KISMAT PEANUT SKINNED 100G', 'PD1197', NULL, NULL, 58.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1197, 2, 'KISMAT PEANUT SKINNED 200G', 'PD1198', NULL, NULL, 110.00, 125.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1198, 2, 'KISMAT MASALA PEANUT 50G', 'PD1199', NULL, NULL, 29.00, 45.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1199, 2, 'KISMAT GANTHIA  100G', 'PD1200', NULL, NULL, 64.00, 75.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1200, 2, 'KISMAT  GANTHIA 50G', 'PD1201', NULL, NULL, 37.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1201, 2, 'KISMAT GANTHIA 200G', 'PD1202', NULL, NULL, 110.00, 125.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1202, 2, 'KISMAT CHEVDA 50G', 'PD1203', NULL, NULL, 42.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1203, 2, 'KISMAT PEANUT SKINNED 50G', 'PD1204', NULL, NULL, 29.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1204, 2, 'KISMAT FAR FAR 50G', '6164002547469', 'C128', NULL, 35.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:28:16'),
(1205, 2, 'KISMAT FAR FAR 30G', '6164002547001', 'C128', NULL, 17.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:28:57'),
(1206, 2, 'KISMAT FAR FAR 100G', '6164002547476', 'C128', NULL, 58.00, 75.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:26:22'),
(1207, 2, 'KISMAT FAR FAR 200G', '6164002547483', 'C128', NULL, 110.00, 125.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:26:52'),
(1208, 2, 'KISMAT POPCORN 30G', '6164002547018', 'C128', -1, 19.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:04:24'),
(1209, 2, 'KISMAT POPCORN 50G', '6164002547025', 'C128', NULL, 28.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 20:23:16'),
(1210, 2, 'KISMAT POPCORN 100G', '6164002547032', 'C128', NULL, 58.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:25:45'),
(1211, 2, 'KISMAT  POPCORN  200G', 'PD1212', NULL, NULL, 104.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1212, 5, 'SUNLIGHT LAVENDER 1KG', '6164004575903', 'C128', NULL, 320.00, 400.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:00:07'),
(1213, 5, 'ARIEL FRESH FLORAL 1KG', '4084500533769', 'C128', NULL, 400.00, 460.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:15:18'),
(1214, 4, 'MOLFIX NO5 36PCS', '6224008817611', 'C128', NULL, 560.00, 650.00, NULL, 'PIECES', 5, 5, NULL, NULL, 1, NULL, NULL, '2024-06-20 21:36:26'),
(1215, 6, 'MOVIT  HERBAL JELLY 70G', '6161107221096', 'C128', NULL, 70.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:13:17'),
(1216, 6, 'MOVIT HERBAL JELLY 100G', '6161107224394', 'C128', NULL, 120.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:13:49'),
(1217, 6, 'BABYCARE JELLY 500G', '6203005140045', 'C128', NULL, 220.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:45:55'),
(1218, 1, 'JOIFA SOYA 20G', '6164003825023', 'C128', NULL, 13.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:52:02'),
(1219, 2, 'NUTS CRISP SWEET', 'PD1220', NULL, NULL, 7.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1220, 2, 'CERELAC  NESTLE (WHEAT) 25G', '6161106962143', 'C128', NULL, 35.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:38:58'),
(1221, 7, 'BANDANA', 'PD1222', NULL, NULL, 34.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1222, 6, 'JELLY COMP', 'PD1223', NULL, NULL, 0.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1223, 1, 'COWBOY COOKING FAT 1KG', '6161107774240', 'C128', NULL, 290.00, 340.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:50:58'),
(1224, 1, 'CROWN  BROWN SUGAR 2KG', 'PD1225', NULL, NULL, 345.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1225, 1, 'GLACIER SPRING WATER 5 LIITRES', 'PD1226', NULL, NULL, 93.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1226, 1, 'UNITED PREMIUM BREAD 400G', 'PD1227', NULL, NULL, 61.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1227, 3, 'HIGHLAND MANGO CORDIAL1 LITRE', '6161102051643', 'C128', NULL, 158.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:32:41'),
(1228, 10, 'TUZO WHOLE MILK 450ML', '6161101680424', 'C128', NULL, 45.00, 55.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 14:52:31'),
(1229, 4, 'SOFTCARE DIAPER LARGE PCS', 'PD1230', 'C128', -1, 17.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:23:14'),
(1230, 4, 'SOFTCARE MEDIUM NO.3', 'PD1231', NULL, NULL, 14.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1231, 3, 'JUST JUICY MANGO FRUIT DRINK 1 LITRE', 'PD1232', NULL, NULL, 140.00, 170.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1232, 3, 'JUST JUICY TROPICAL 1 LITRE', '024000109624', 'C128', NULL, 140.00, 170.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:52:22'),
(1233, 3, 'JUST JUICY APPLE 1LR', '024000109600', 'C128', NULL, 140.00, 170.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:53:21'),
(1234, 3, 'JUICY JUICY MANGO 250ML', 'PD1235', NULL, NULL, 42.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1235, 3, 'JUST JUICY APPLE 250ML', '024000109556', 'C128', NULL, 43.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:23:53'),
(1236, 3, 'JUST JUICY MIXED BERRIES 250ML', '024000109563', 'C128', NULL, 43.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:22:59'),
(1237, 3, 'SUNFRESH SAUCE  250G', '6162000049046', 'C128', NULL, 42.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:54:34'),
(1238, 3, 'SUNFRESH  SAUCE 400G', '6162000049077', 'C128', NULL, 59.00, 85.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:54:02'),
(1239, 3, 'JUST  JUICY TROPICAL 250ML', '024000109570', 'C128', NULL, 42.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 14:24:33'),
(1240, 3, 'SUNFRESH SAUCE 700G', '6162000049060', 'C128', NULL, 90.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:53:16'),
(1241, 3, 'ZESTA TOMATO  SAUCE  700G', '6162000020021', 'C128', NULL, 150.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:45:27'),
(1242, 5, 'STASOFT  LAVENDER 20ML', 'PD1243', NULL, NULL, 18.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1243, 5, 'STASOFT SPRING FRESH 20ML', 'PD1244', NULL, NULL, 18.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1244, 5, 'STASOFT OCEAN FRESH 20ML', 'PD1245', NULL, NULL, 18.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1245, 5, 'SUPER GLUE RED SUN 3G', 'PD1246', NULL, NULL, 24.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1246, 6, 'GIFT  WRAPPER', 'PD1247', NULL, NULL, 10.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1247, 7, 'STUDENT SCISSORS', 'PD1248', NULL, NULL, 40.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1248, 10, 'LATO MILK VANILLA125ML', '6164002812598', 'C128', NULL, 28.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:25:22'),
(1249, 10, 'LATO MILK STRAWBERRY 125ML', '6164002812604', 'C128', NULL, 28.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:26:11'),
(1250, 2, 'ZESTA TOMATO SAUCE 20G', '6162000049084', 'C128', NULL, 3.00, 5.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:55:55'),
(1251, 1, 'KINGSMILL WHITE BREAD 800G', 'PD1252', NULL, NULL, 120.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1252, 3, 'HIGHLANDS COCOPINE CORDIAL 1 LITRE', '6161102051490', 'C128', NULL, 165.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:34:01'),
(1253, 3, 'HIGHLAND ORANGE CORDIAL 1 LITRE', '6161102051032', 'C128', NULL, 165.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:29:47'),
(1254, 3, 'HIGHLANDS DRINKING WATER 1 LITRE', '6161102050035', 'C128', NULL, 30.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:32:03'),
(1255, 4, 'HIGHLANDS DRINKING WATER 500ML', '6161102050011', 'C128', NULL, 18.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:30:49'),
(1256, 2, 'MILK FLAVOURED LOLLIPOP', 'PD1257', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1257, 6, 'LURON VANISHING CREAM 50ML', '6161102024494', 'C128', NULL, 160.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 19:29:40'),
(1258, 2, 'KING EGG SHAPED ', 'PD1259', NULL, NULL, 15.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1259, 5, 'ERIPRIDE LEMON 500ML', '6164003349215', 'C128', NULL, 130.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:00:05'),
(1260, 3, 'SPRITE 350ML', '40822099', 'C128', -2, 45.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:39:33'),
(1261, 6, 'MISS LOOK LIP GLOSS RED 10ML', 'PD1262', 'C128', NULL, 70.00, 100.00, NULL, 'PIECES', 5, 5, NULL, NULL, 1, NULL, NULL, '2024-06-20 20:06:23'),
(1262, 6, 'LIP GLOSS (TOP LADY) 12ML', 'PD1263', NULL, NULL, 70.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1263, 3, 'ACACIA APPLE KIDS DRINK 200ML', '6161110811284', 'C128', NULL, 35.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:52:54'),
(1264, 3, 'FANTA ORANGE  500ML', 'PD1265', NULL, NULL, 46.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1265, 3, 'STONEY 350ML', '42357728', 'C128', NULL, 45.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:07:59'),
(1266, 6, 'NICE & LOVELY MILK CREAM 100ML', '6161110963600', 'C128', NULL, 120.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:37:54'),
(1267, 6, 'THERAPEUTIC MASSAGE OIL(MINT) 500ML', 'PD1268', NULL, NULL, 250.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1268, 6, 'THERAPEUTIC MASSAGE OIL(EUCALYPTUS) 500ML', 'PD1269', NULL, NULL, 250.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1269, 6, 'THERAPEUTIC MASSAGE OIL (MINT) 1 LITRE', 'PD1270', NULL, NULL, 450.00, 550.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1270, 6, 'THERAPEUTIC MASSAGE OIL (EUCALYPTUS) 1LITRE', 'PD1271', NULL, NULL, 450.00, 550.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1271, 7, 'SIFA SERVIETTES', '6161101891967', 'C128', NULL, 75.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:31:11'),
(1272, 7, 'HANAN KITCHEN TOWELS', '6164002695283', 'C128', NULL, 294.00, 350.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:26:12'),
(1273, 1, 'SPENZA PREMIUM MAIZE MEAL 2KG', 'PD1274', NULL, NULL, 196.00, 225.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1274, 6, 'BEULA PETROLEUM JELLY 75G', '6164004700961', 'C128', NULL, 62.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:55:02'),
(1275, 6, 'BEULA BABY JELLY 125G', '6161115200014', 'C128', NULL, 97.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:53:20'),
(1276, 6, 'BEULA ALOE PETROLEUM JELLY 125G', '6161115200137', 'C128', NULL, 97.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:52:27'),
(1277, 6, 'BEULA BABY JELLY PERFUMED 75G', '6161115200045', 'C128', NULL, 62.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:57:21'),
(1278, 6, 'BEULA COCOA BUTTER 75G', '6161115200083', 'C128', NULL, 62.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:55:44'),
(1279, 5, 'HARPIC 500ML', '6161100952430', 'C128', NULL, 460.00, 500.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:01:56'),
(1280, 9, 'CAMERA BABY FEEDER', '4711146100399', 'C128', NULL, 0.00, 0.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:20:52'),
(1281, 1, 'SUN ICE MANGO JUICE 200ML', 'PD1282', NULL, NULL, 31.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1282, 2, 'SOLY GUAVA JUICE  200ML', 'PD1283', NULL, NULL, 32.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1283, 12, 'LINELIX GAS BURNER AND VALVE', 'PD1284', NULL, NULL, 0.00, 280.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1284, 12, 'COSCO REGULATOR', 'PD1285', NULL, NULL, 0.00, 450.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1285, 12, 'AMPIA GAS GAUGE REGULATOR', 'PD1286', NULL, NULL, 0.00, 650.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1286, 12, 'PAC REGULATOR ', 'PD1287', NULL, NULL, 0.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1287, 12, 'E-GAZ BURNER AMD VALVE', 'PD1288', NULL, NULL, 0.00, 320.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1288, 12, 'CAM GAS REGULATOR', 'PD1289', NULL, NULL, 0.00, 400.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1289, 2, 'PETIT BEURRE SUN VEAT', 'PD1290', NULL, NULL, 27.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1290, 6, 'LUSTROUS DODWELL NAIL ENAMEL', 'PD1291', NULL, NULL, 0.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1291, 9, 'BETA BASIN ', 'PD1292', NULL, NULL, 0.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1292, 9, 'KASUMU BASIN ', 'PD1293', NULL, NULL, 0.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1293, 9, 'MUNGETHO BASIN', 'PD1294', NULL, NULL, 0.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1294, 9, 'MUNGETHO BASIN LARGE', 'PD1295', NULL, NULL, 0.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1295, 4, 'HANAN PREMIUM TISSUE 4 ROLLS', '6164000242496', 'C128', NULL, 0.00, 220.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:14:38'),
(1296, 4, 'HANAN PREMIUM SERVIETTES 100 SHEETS', '6164000242489', 'C128', NULL, 0.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:31:54'),
(1297, 4, 'BELLA BABY WIPES 40PCS', '6161114908744', 'C128', NULL, 0.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:36:33'),
(1298, 10, 'MOUNT KENYA KABEBE MILK 400ML', 'PD1299', NULL, NULL, 42.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1299, 10, 'GOLD CROWN MILK 200ML', '6161100460133', 'C128', NULL, 26.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:24:15'),
(1300, 1, 'TWO TEN HOME BAKING FLOUR 1KG', '6164000726156', 'C128', -1, 85.00, 95.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 02:23:08'),
(1301, 1, 'PETTII TOMATO PASTE 400G', 'PD1302', NULL, NULL, 110.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1302, 1, 'KENYLON TOMATO PASTE 450G', '6162000048872', 'C128', NULL, 195.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:41:23'),
(1303, 1, 'TANA PISHORI 1KG', 'PD1304', NULL, NULL, 126.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1304, 1, 'TANA PISHORI 1/2KG', 'PD1305', NULL, NULL, 63.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1305, 1, 'TANA PISHORI 1/4 KG', 'PD1306', NULL, NULL, 32.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1306, 12, 'TOCEBAL BATTERY AA', 'PD1307', NULL, NULL, 27.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1307, 11, 'FRUIT SHARPNER', 'PD1308', NULL, NULL, 21.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1308, 1, 'RING CAKE CHOCOLATE 90G', 'PD1309', NULL, NULL, 45.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1309, 1, 'RING CAKE STRAWBERRY 90G', 'PD1310', NULL, NULL, 45.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1310, 4, 'HANAN PREMIUM TISSUE 2 ROLLS', '6164000242410', 'C128', NULL, 90.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:14:00'),
(1311, 2, 'ZESTA CHILL SAUCE 375G', '6162000048575', 'C128', NULL, 82.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:47:35'),
(1312, 2, 'ZESTA CHILL SAUCE 240G', '6162000020519', 'C128', NULL, 55.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:50:01'),
(1313, 4, 'JAMBO TOILET PAPER                                      ', 'PD1314', NULL, NULL, 15.00, 25.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1314, 5, 'PRIDE M/PURPOSE LEMON FRESH 1L', '6161100881686', 'C128', NULL, 220.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:37:16'),
(1315, 6, 'DODWELL NAIL ENAMEL 14ML(CUTEX)', 'PD1316', NULL, NULL, 30.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1316, 6, 'NIVEA MEN MAX HYDRATION 200ML', '4005808661831', 'C128', NULL, 280.00, 360.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:09:38'),
(1317, 5, 'AIROMA OCEAN SPRAY AIR FRESHENER 300ML', 'PD1318', NULL, NULL, 140.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1318, 5, 'AIROMA FLORAL BLOOM AIR FRESHNER 300ML', 'PD1319', NULL, NULL, 140.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1319, 6, 'MOVIT BABY POWDER 50G', '6164000823343', 'C128', NULL, 50.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:34:36'),
(1320, 4, 'KOTEX PANTY LINERS NORMAL', '5029053569369', 'C128', NULL, 133.00, 200.00, NULL, 'PIECE', 5, 5, NULL, NULL, 1, NULL, NULL, '2024-06-20 20:12:46'),
(1321, 2, 'MULT STARS CHOCOLATE', 'PD1322', NULL, NULL, 9.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1322, 2, 'CHOCO THREE-COLOR ICE CREAM ', 'PD1323', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1323, 2, 'CADBURY DAIRY MILK CHOCOLATE 80G', '6001065601069', 'C128', NULL, 202.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:44:39'),
(1324, 2, 'CADBURY DREAM BISCUIT CHOCOLATE 80G', '6001065601052', 'C128', NULL, 203.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:55:20'),
(1325, 4, 'NILE SERVIETE', 'PD1326', NULL, NULL, 65.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1326, 2, 'SNACK CAR TICTAC', 'PD1327', NULL, NULL, 11.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1327, 2, 'KISMAT CHEVDA 100G', 'PD1328', NULL, NULL, 78.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1328, 11, 'PLASTIC BOOK COVER', '6161102262469', 'C128', NULL, 120.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:29:44'),
(1329, 11, 'A6 NOTE BOOK NO.4', 'PD1330', NULL, NULL, 35.00, 55.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1330, 11, 'HARD COVER A5 SINGLE RULED 200PGS', '6161102121117', 'C128', NULL, 98.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:55:14'),
(1331, 11, 'A5 HALF INCH SINGLE LINE 96PGS', 'PD1332', NULL, NULL, 35.00, 45.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1332, 11, 'A5 HALF INCH SINGLE LINE 48PGS', 'PD1333', NULL, NULL, 21.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1333, 11, 'KASUKU A5 PLAIN 48 PGS', '6161101537018', 'C128', NULL, 10.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:44:56'),
(1334, 11, 'KASUKU A5 IRISH 48PGS', '6161101537216', 'C128', NULL, 10.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:43:50'),
(1335, 11, 'A5 BROWN COVER ', 'PD1336', NULL, NULL, 120.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1336, 11, 'A4 LEKHAN EXERCISE BOOK', 'PD1337', NULL, NULL, 200.00, 240.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1337, 5, 'KENLEX DISHWASHING  LEMON 500ML', 'PD1338', 'C128', NULL, 120.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:33:06'),
(1338, 2, 'NUVITA WAFERS BANANA', '6161103943404', 'C128', NULL, 3.00, 5.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:31:41'),
(1339, 5, 'TOSS 200G', '6161101661850', 'C128', NULL, 68.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:07:16'),
(1340, 7, 'ROSY SERVIETTES 100 PCS', '6161100160231', 'C128', NULL, 72.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:33:19'),
(1341, 7, 'DOVE COTTON WOOL 50G', 'PD1342', NULL, NULL, 80.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1342, 10, 'ILARA MILK 500ML', 'PD1343', NULL, NULL, 58.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1343, 4, 'HANAN ANTI-BACTERIAL POCKET  WIPES 20PCS', 'PD1344', NULL, NULL, 86.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1344, 3, 'MELVIS TANGAWIZI 15G', 'PD1345', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1345, 3, 'FAHARI YA KENYA 15G', 'PD1346', NULL, NULL, 8.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1346, 1, 'ROYCO MCHUZI MIX CHICKEN12G', '6161115175145', 'C128', NULL, 8.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:10:27'),
(1347, 1, 'INDIAN BIRYAN RICE 1KG', 'PD1348', NULL, NULL, 113.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1348, 1, 'INDIAN BIRYAN RICE 1/2 KG', 'PD1349', NULL, NULL, 57.00, 65.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1349, 1, 'INDIAN BIRYAN RICE 1/4KG', 'PD1350', NULL, NULL, 28.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1350, 7, 'SCISSORS SMALL', 'PD1351', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1351, 2, 'TING TING TROPICAL FLAVOUR', '6161112463900', 'C128', NULL, 3.00, 5.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:23:10'),
(1352, 1, 'RAHA KAVANGARA MAIZE MEAL 1KG', '792382315611', 'C128', NULL, 103.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:16:05'),
(1353, 4, 'ROSY 4 ROLLS TISSUE PAPER', '6161100762473', 'C128', NULL, 114.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:17:14'),
(1354, 1, 'SUNRISE BASMATI RICE 2KG', '6164000512001', 'C128', NULL, 558.00, 640.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:02:16'),
(1355, 6, 'VALON PERFUMED WHITE JELLY 250ML', '6161100882379', 'C128', NULL, 210.00, 270.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:48:41'),
(1356, 6, 'VALON PURE WHITE JELLY 250ML', '6161100882317', 'C128', NULL, 210.00, 270.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:49:24'),
(1357, 6, 'VALON  PURE WHITE JELLY 100ML', '6161100882294', 'C128', NULL, 98.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:49:54'),
(1358, 6, 'VALON MEN WHITE JELLY 100ML', '6161100882393', 'C128', NULL, 90.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:50:35'),
(1359, 6, 'VALON COCOA SOFT WHITE JELLY 100ML', '6161100882423', 'C128', NULL, 97.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:51:04'),
(1360, 7, 'VASELINE FOR MEN FRESH 95ML', '61614178', 'C128', NULL, 0.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:06:44'),
(1361, 7, 'VASELINE FOE MEN FRESH 45ML', '61614130', 'C128', NULL, 50.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 00:48:33'),
(1362, 5, 'GEISHA MORINGA OIL SOAP  90G', '6164004625950', 'C128', NULL, 63.00, 110.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:24:45'),
(1363, 5, 'GEISHA TRADITIONAL BLACK SOAP 90G', '6161115172328', 'C128', NULL, 83.00, 110.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:23:39'),
(1364, 5, 'SUNLIGHT SPRING POWDER 150G', '6161115173011', 'C128', NULL, 44.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 09:46:29'),
(1365, 5, 'SUNLIGHT JAR TROPICAL POWDER SOAP 500G', 'PD1366', NULL, NULL, 206.00, 240.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1366, 7, 'PEPSODENT CHARCOAL WHITE 30G', '8934839133634', 'C128', NULL, 60.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:16:43'),
(1367, 7, 'PEPSODENT HERBAL TOOTHPASTE 30G', '8934839129668', 'C128', NULL, 40.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 01:10:44'),
(1368, 1, 'ZESTA BI-CARBONATE OF SODA 100G', '6162000024319', 'C128', NULL, 22.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:05:18'),
(1369, 1, 'ZESTA BI-CARBONATE OF SODA 100G(BAKING)', '6162000024326', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:05:50'),
(1370, 1, 'ZESTA PURE NATURAL HONEY 500G', '6162000048438', 'C128', NULL, 399.00, 450.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:02:36'),
(1371, 1, 'ZESTA ICING SUGAR 500G', '6162000024128', 'C128', NULL, 123.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:17:33'),
(1372, 1, 'EXE SELF RAISING FLOUR 1KG', 'PD1373', NULL, NULL, 103.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1373, 7, 'CLOSE UP TOOTHPASTE 60G', '8934839126544', 'C128', NULL, 80.00, 110.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:22:06'),
(1374, 7, 'CLOSE UP TOOTHPASTE 30G', '8934839126551', 'C128', NULL, 50.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:23:23'),
(1375, 11, 'MASKING TAPE', 'PD1376', NULL, NULL, 30.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1376, 11, 'GEL SUPER SMOOTH PEN', 'PD1377', NULL, NULL, 25.00, 25.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1377, 2, 'POLICE CAR TOY CANDY', 'PD1378', NULL, NULL, 13.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1378, 2, 'BRITANNIA BOURBON CHOCOLATE', 'PD1379', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1379, 5, 'DOVEBLUE BEAUTY CREAM BAR 90G', 'PD1380', NULL, NULL, 200.00, 240.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1380, 5, 'MORTEIN DOOM INSECT KILLER 100ML', '6161100952256', 'C128', -1, 195.00, 240.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 16:11:07'),
(1381, 1, 'ZESTA SMOOTH  PEANUT BUTTER 250G', '6162000023831', 'C128', NULL, 148.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:06:16'),
(1382, 2, 'PEANUT COOKIES BISCUITS 75G', 'PD1383', NULL, NULL, 25.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1383, 2, 'CHOC-CHIPS COOKIES BISCUITS 75G', 'PD1384', NULL, NULL, 25.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1384, 1, 'MUMIAS SUGAR 2KG', 'PD1385', NULL, NULL, 177.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1385, 10, 'TUZO ESL MILK 200ML', '6161101680431', 'C128', -1, 22.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:07:59'),
(1386, 1, 'MELVIS TANGAWIZI CHAI 100G', '6161102040814', 'C128', NULL, 59.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:30:54'),
(1387, 1, 'ROYCO CURRY & SPICE 10G', '6161115173882', 'C128', NULL, 7.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:04:48'),
(1388, 1, 'ROYCO PILAU MASALA SPICES 10G', '6161115173875', 'C128', NULL, 18.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:05:39'),
(1389, 1, 'ROYCO NYAMA CHOMA SPICES 10G', '6161115174537', 'C128', NULL, 18.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:06:37');
INSERT INTO `products` (`id`, `category_id`, `product_name`, `product_code`, `product_barcode_symbology`, `product_quantity`, `product_cost`, `product_price`, `wholesale_price`, `product_unit`, `product_stock_alert`, `product_order_tax`, `product_tax_type`, `product_note`, `supplier_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1390, 1, 'ROYCO WET AND DRY FRY SPICE 10G', '6161115174544', 'C128', NULL, 18.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:58:33'),
(1391, 5, 'OMO HAND WASHING POWER 200G', '6162006602757', 'C128', NULL, 66.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 09:56:41'),
(1392, 3, 'DORMANS FINE INSTANT COFFEE 100G', 'PD1393', NULL, NULL, 515.00, 610.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1393, 3, 'DORMANS GRANULATED INSTANT COFFEE 100G', 'PD1394', NULL, NULL, 555.00, 630.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1394, 1, 'DORMANS FINE COFFEE 50G', '6161100860001', 'C128', NULL, 290.00, 335.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:40:33'),
(1395, 1, 'DORMANS GRANULATED INSTANT COFFEE 50G', '6161100860551', 'C128', NULL, 305.00, 345.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:39:23'),
(1396, 3, 'DORMANS KENYA KAHAWA 25G', '6161100861244', 'C128', NULL, 23.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:34:36'),
(1397, 2, 'FLYIN CHEETAH CORN SNACKS', 'PD1398', NULL, NULL, 7.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1398, 2, 'FLYIN CHEETAH FRUITY CORN ', 'PD1399', NULL, NULL, 7.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1399, 5, 'ARGAN LIQUID HAND WASH 500ML', 'PD1400', NULL, NULL, 130.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1400, 6, 'BAMSI MOULDING GEL WAX 80G', '745240426196', 'C128', NULL, 120.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:07:19'),
(1401, 6, 'SOFTY CARROT BODY CREAM 100ML', '6203015930193', 'C128', NULL, 50.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:58:55'),
(1402, 2, 'COCOALOVERSSANDWICH34G', 'PD1403', NULL, NULL, 41.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1403, 2, 'N\'GOES PEANUT', '8683960000772', 'C128', -2, 73.00, 95.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:44:26'),
(1404, 2, 'CAPTAINPEANUT', '8683960000321', 'C128', NULL, 44.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:23:25'),
(1405, 2, 'BIG HAPPY STRAWBERRY CHOCOLATE', '6164002740525', 'C128', NULL, 4.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:34:23'),
(1406, 2, 'BRITANNIAGOODDAYCOOKIES', 'PD1407', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1407, 2, 'MELDAELBOWMAKARON500G', 'PD1408', NULL, NULL, 92.00, 110.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1408, 3, 'MR ONE GUAVA 200ML', '6220857050117', 'C128', NULL, 33.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:37:34'),
(1409, 3, 'APPLE JUICE 225ML', 'PD1410', NULL, NULL, 33.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1410, 3, 'MRONEAPPLEJUICE200ML', 'PD1411', NULL, NULL, 33.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1411, 3, 'GUAVAJUICE225ML', 'PD1412', NULL, NULL, 33.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1412, 5, 'CUSSONS BABY MILD100G', '6161102001921', 'C128', NULL, 73.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:07:45'),
(1413, 5, 'SUNLIGHTDISHWASHINGPASTE250G', '6162006608544', 'C128', NULL, 100.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:44:10'),
(1414, 6, 'VASELINECOCOABUTTERJELLY240ML', 'PD1415', NULL, NULL, 242.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, '2024-06-21 00:55:08', NULL, '2024-06-21 00:55:08'),
(1415, 6, 'VASELINEALOEVERAJELLY240ML', '6161115174162', 'C128', NULL, 242.00, 300.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:02:47'),
(1416, 5, 'DOVEPINK/ROSA135G', '7501056349288', 'C128', NULL, 150.00, 220.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:38:56'),
(1417, 7, 'PEPSODENTCAVITYFIGHTER150G', '8934839128265', 'C128', NULL, 160.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:19:06'),
(1418, 7, 'PEPSODENTHERBAL150G', '8934839129682', 'C128', NULL, 160.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:14:43'),
(1419, 2, 'WAVES TOMATO CRISPS 30G', '6161100914421', 'C128', NULL, 45.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:55:25'),
(1420, 7, 'ABUJABAGS', 'PD1421', NULL, NULL, 140.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1421, 7, 'ABUJABAGS#2', 'PD1422', NULL, NULL, 130.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1422, 7, 'ABUJA#3', 'PD1423', NULL, NULL, 110.00, 140.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1423, 7, 'ABUJA#4', 'PD1424', NULL, NULL, 90.00, 120.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1424, 7, 'FASHIONBAGS', 'PD1425', NULL, NULL, 30.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1425, 7, 'ABUJASMALLBAG', 'PD1426', NULL, NULL, 80.00, 110.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1426, 2, 'PRINCECHOCOLATE', 'PD1427', NULL, NULL, 35.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1427, 2, 'PRINCE CHOCOLATE BISCUIT50G', '8961003612022', 'C128', NULL, 35.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:49:04'),
(1428, 7, 'CICA TOPCYCLLE PADLOCK60MM', 'PD1429', NULL, NULL, 350.00, 700.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1429, 7, 'MINDY SILVER  TOPSECURITYLOCK   60MM', 'PD1430', NULL, NULL, 350.00, 800.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1430, 7, 'HARD-CIRCLEPADLOCK 50MM', 'PD1431', NULL, NULL, 55.00, 140.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1431, 5, 'SAVANNAH  GARDEN 120G', '6291003615139', 'C128', NULL, 40.00, 70.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:17:39'),
(1432, 5, 'SAVANNAH 4 PACK BREEZE 400G', '6291003612060', 'C128', NULL, 90.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:27:46'),
(1433, 7, 'LUDE  BLACK SHOE  POLISH80G/100ML', '6901997605336', 'C128', NULL, 138.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:51:30'),
(1434, 7, 'TOOTHPICK22', 'PD1435', NULL, NULL, 17.00, 25.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1435, 4, 'SOFTCARE  SMART  PADS', '6164004723359', 'C128', NULL, 50.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:43:17'),
(1436, 5, 'GUARDEX ENCHANTING SOAP', '6291003618024', 'C128', NULL, 40.00, 70.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:21:47'),
(1437, 4, 'MOLFIX  MEDIUM NO3.', '6224008817550', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:56:33'),
(1438, 4, 'MOLFIX  SMALLNO2.', '6224008817529', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:57:08'),
(1439, 4, 'MOLFIX DIAPERS NO4.', '6224008817581', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:57:48'),
(1440, 5, 'JIKCOLOURS 70ML', 'PD1441', NULL, NULL, 39.00, 45.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1441, 1, 'MUMIAS SUGAR 1KG', '6161116110008', 'C128', NULL, 165.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:51:48'),
(1442, 5, 'FLAMIG0  ALOE VERA  &  HONEY   90G', '6161102003390', 'C128', NULL, 115.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:22:40'),
(1443, 5, 'FLAMINGO LEMON & HONEY  90G', '6161102003369', 'C128', NULL, 115.00, 150.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:25:44'),
(1444, 5, 'FLAMINGO COCONUT  &  HONEY 90G', '6161102003420', 'C128', NULL, 115.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:23:57'),
(1445, 5, 'FLAMINGO  MARULA & HONEY 90G', '6161116240057', 'C128', NULL, 43.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:33:21'),
(1446, 5, 'FLAMINGO TRADITIONAL BLACK SOAP 90G', 'PD1447', NULL, NULL, 43.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1447, 5, 'FLAMINGO COCONUT MILK & HONEY 90G', '6161116240026', 'C128', NULL, 43.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:30:28'),
(1448, 11, 'COUNTER BOOK 192PGS', '6161102781083', 'C128', NULL, 160.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:59:13'),
(1449, 2, 'DANA VINEGAR WHITE 700ML', '6161106190096', 'C128', NULL, 67.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:16:17'),
(1450, 5, 'LUX VELVET GLOW 172G', '8961014237368', 'C128', NULL, 129.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:05:27'),
(1451, 5, 'LUX ROSE GLOW SOAP', 'PD1452', NULL, NULL, 129.00, 160.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1452, 5, 'BAYGON INSECT SPRAY', '6001298899820', 'C128', NULL, 0.00, 0.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:12:19'),
(1453, 6, 'DISAAR HAIR REMOVAL CREAM 100G', '6932511216899', 'C128', NULL, 200.00, 300.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 19:30:17'),
(1454, 6, 'VEET PURE HAIR REMOVAL CREAM 30G', '8901396387237', 'C128', NULL, 210.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 19:28:12'),
(1455, 6, 'CUSSONS BABY BLUE OIL 100ML', '88820286', 'C128', NULL, 200.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 19:25:27'),
(1456, 5, 'USHINDI CREAM 175G', '6161106612703', 'C128', NULL, 40.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:36:54'),
(1457, 5, 'USHINDI WITH GLYCERINE 175G', 'PD1458', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1458, 5, 'USHINDI WITH STAIN REMOVER 175G', '6161106612710', 'C128', NULL, 40.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:37:38'),
(1459, 5, 'USHINDI LEMON FRAGRANCE 175G', 'PD1460', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1460, 6, 'CHARM MAX NAIL LACQUER 20ML', 'PD1461', NULL, NULL, 40.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1461, 6, 'SMALL CUTEX ', 'PD1462', NULL, NULL, 30.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1462, 2, 'DELAMERE STRAWBERRIES 150G', 'PD1463', NULL, NULL, 71.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1463, 2, 'ANGEL DRY YEAST 100G', '6917790976269', 'C128', NULL, 95.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:07:14'),
(1464, 11, 'NATARAJ SHARPNER', 'PD1465', NULL, NULL, 18.00, 25.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1465, 2, 'COCACOLACANDY', 'PD1466', NULL, NULL, 13.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1466, 10, 'PRIDE OF COWS MILK 500ML', 'PD1467', NULL, NULL, 45.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1467, 8, 'EARBUDS PRETTY', 'PD1468', NULL, -1, 17.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:44:26'),
(1468, 8, 'EARBUNSSMALL', 'PD1469', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1469, 2, 'TOMATOPASTESANTAMARIA70G', '6164004454901', 'C128', -1, 33.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:47:50'),
(1470, 7, 'KIWISHOEPOLISH25ML/20G', '616110897009', 'C128', NULL, 95.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:46:02'),
(1471, 10, 'PROBIOTIC  YOGHURT STRAWBERRIES  450G', '6161107151485', 'C128', -1, 148.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:15:06'),
(1472, 10, 'PROBIOTIC YOGHURT  VANILLA  450G', '6161107151492', 'C128', -1, 148.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 00:09:39'),
(1473, 10, 'PROBIOTIC YOGHURT STRAWBERRIES 250G', '6161107151508', 'C128', NULL, 90.00, 100.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 19:30:16'),
(1474, 10, 'PROBIOTIC YOGHURT NATURAL 250G', '6161107150389', 'C128', NULL, 90.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:02:47'),
(1475, 11, 'KASUKU GLUE STICK 21G', '6161101532877', 'C128', NULL, 95.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:23:45'),
(1476, 9, 'JINICE PARTY CUPS 25PCS', 'PD1477', NULL, NULL, 75.00, 95.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1477, 9, 'JINICE SMALL  PARTY CUPS 25PCS', 'PD1478', NULL, NULL, 45.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1478, 9, 'THERMOL PARTY CUP 50PCS', 'PD1479', NULL, NULL, 50.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1479, 3, 'AFIA MULTI VITAMIIN 300ML', 'PD1480', NULL, NULL, 43.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1480, 6, 'VASELINE COCOABUTTER 95ML', '61614208', 'C128', NULL, 129.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:03:49'),
(1481, 6, 'VASELINE ALOE VERA 95ML', '61614215', 'C128', NULL, 129.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 05:06:11'),
(1482, 6, 'VASELINE BABYPERFUMED  95ML', '61614192', 'C128', NULL, 129.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 00:52:32'),
(1483, 6, 'SEDOSO  SHOWER GEL 400ML', 'PD1484', NULL, NULL, 210.00, 270.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1484, 6, 'SEDOSO  SHOWER GEL 400ML(TOFEE)', '792649123959', 'C128', NULL, 210.00, 270.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:19:39'),
(1485, 6, 'SEDOSO ALMOND VANNILA 200ML', '745178423533', 'C128', NULL, 105.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:12:58'),
(1486, 6, 'SEDOSO  ALOE VERA 200ML', 'PD1487', NULL, NULL, 105.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1487, 6, 'SEDOSO FOR MEN 120ML', '0769503877266', 'C128', NULL, 1.00, 1.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:42:41'),
(1488, 6, 'SEDOSO SHOWERGEL MEN 400ML', '792649123942', 'C128', NULL, 225.00, 270.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:16:06'),
(1489, 4, 'NILE  TISSUE', 'PD1490', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1490, 4, 'MOLPED  PANTYLINER 16PCS', 'PD1491', NULL, NULL, 118.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1491, 2, 'CREAM WAFERS CHOCOLATE', 'PD1492', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1492, 2, 'YEGO  FAMILY BISCUITS 60G', '6164002695153', 'C128', NULL, 15.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:50:00'),
(1493, 3, 'SCHWEPPES BITTER LEMON 500ML', 'PD1494', NULL, NULL, 75.00, 80.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1494, 2, 'ZESTA HOT N SWEET SAUCE 420G', '6162000020663', 'C128', NULL, 80.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:48:59'),
(1495, 2, 'GOLDEN BEE HONEY 250G', '6166000143162', 'C128', NULL, 260.00, 310.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:00:38'),
(1496, 2, 'GOLDEN  BEE  HONEY100G', '6166000143148', 'C128', NULL, 80.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:15:08'),
(1497, 5, 'DETTOL SKINCARE SOAP 90G', '6161100952614', 'C128', NULL, 130.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 21:16:42'),
(1498, 5, 'DETTOL INSTANT COOL 90G', '6161100952638', 'C128', -1, 130.00, 150.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 23:28:53'),
(1499, 7, 'HANAN POCKET TISSUES 10PCS', 'PD1500', NULL, NULL, 16.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1500, 4, 'ULTRA COMFORT WET WIPES', 'PD1501', NULL, NULL, 50.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1501, 5, 'CLASSIC MULT-PURPOSE SOAP 1KG', '6161101660396', 'C128', NULL, 145.00, 165.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:51:13'),
(1502, 5, 'SALAMA MULTIPURPOSE BAR  SOAP 1KG', '6164003882354', 'C128', NULL, 139.00, 165.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 23:06:51'),
(1503, 5, 'MSAFI WASHING  BAR SOAP 1KG', '6161107777432', 'C128', NULL, 144.00, 170.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:59:23'),
(1504, 5, 'KIBUYU WASHING BAR SOAP 1KG', '6161100907614', 'C128', NULL, 145.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:42:43'),
(1505, 10, 'CADBURY  COCOA POWDER  200G', '7622210304476', 'C128', NULL, 440.00, 500.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:26:50'),
(1506, 1, 'GARDENHONEY300G', '6164001954008', 'C128', NULL, 170.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:17:34'),
(1507, 2, 'GARDEN ROASTED PEANUT 200G', '686909984773', 'C128', NULL, 95.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:35:44'),
(1508, 2, 'GARDEN ROASTED PEANUT 100G', '6164001954121', 'C128', NULL, 50.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:35:07'),
(1509, 2, 'GARDEN ROASTED PEANUT 50G', '6164001954091', 'C128', NULL, 26.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:34:25'),
(1510, 2, 'OREO  CADBURY  COATEDCHOCOLATE 32.9G', '7622201703011', 'C128', -1, 39.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 00:09:39'),
(1511, 1, 'BASMAT  RICE 1KG', 'PD1512', NULL, NULL, 148.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1512, 1, 'BASMAT RICE1/2KG', 'PD1513', NULL, NULL, 74.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1513, 1, 'BASMAT RICE  1/4', 'PD1514', NULL, NULL, 37.00, 45.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1514, 5, 'SUNLIGHT D/WASH ANTIBACTERIAL 400ML', '6164004801651', 'C128', NULL, 149.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:23:47'),
(1515, 5, 'SUNLIGHT DISHWASHING  PASTE 400G', '6162006608551', 'C128', NULL, 183.00, 220.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:45:27'),
(1516, 5, 'SUNLIGHT BAR SOAP 700G', '6161109723673', 'C128', NULL, 247.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 23:05:37'),
(1517, 5, 'GEISHA TRADITIONAL BLACK SOAP 200G', '6161115173455', 'C128', NULL, 117.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:25:42'),
(1518, 5, 'GEISHA MORINGA OIL SOAP 200G', '6164004625943', 'C128', NULL, 117.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:48:52'),
(1519, 2, 'ROYCO PILAU MASALA 50G', '6161115173721', 'C128', NULL, 130.00, 170.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:14:42'),
(1520, 2, 'MANJI  SHORTCAKE BISCUITS', 'PD1521', NULL, NULL, 0.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1521, 2, 'MANJI  SHORTCAKE  BISCUIT 100G', '6161101251860', 'C128', NULL, 45.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:41:11'),
(1522, 2, 'SUNVEAT  NICE COCONUT 75G', 'PD1523', NULL, NULL, 25.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1523, 5, 'KENLEX DISHWASHING LEMON 1L', '725765258076', 'C128', NULL, 200.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 00:20:41'),
(1524, 5, 'IVY  HANDWASH APPLE SNAPPLE475ML', 'PD1525', NULL, NULL, 120.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1525, 5, 'IVY MIDNIGHT JASMINE HANDWASH 475ML', 'PD1526', NULL, NULL, 120.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1526, 5, 'IVY BERRY BLAST', 'PD1527', NULL, NULL, 120.00, 180.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1527, 6, 'CUSSONS BABY OIL PINK 100ML', '8998103004495', 'C128', NULL, 200.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 19:26:00'),
(1528, 6, 'CUSSONS BABY POWDER VANILLA50G', '8888103201010', 'C128', NULL, 150.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:32:25'),
(1529, 6, 'CUSSONS BABY POWDER SAKURA 50G', '8998103000565', 'C128', NULL, 150.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:33:42'),
(1530, 5, 'DUAL DISHWASHING LIQUID  500ML', '6161104344613', 'C128', NULL, 200.00, 240.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:28:27'),
(1531, 4, 'HANAN PREMIUM TISSUE 10ROLLS', 'PD1532', NULL, NULL, 400.00, 580.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1532, 3, 'SAFARI ENERGY BOOSTER 300ML', 'PD1533', NULL, NULL, 40.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1533, 4, 'BELLA UNWRAPPED WHITE TISSUE 10 ROLLS', 'PD1534', NULL, NULL, 350.00, 400.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1534, 1, 'PRESTIGE MARGARINE  100G', '6161101661423', 'C128', NULL, 39.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:59:14'),
(1535, 1, 'JOPO SIFTED MAIZE MEAL 2KG', 'PD1536', NULL, NULL, 106.00, 125.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1536, 8, 'HEALTHYTOUCH SPIRIT 300ML', 'PD1537', NULL, NULL, 70.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1537, 8, 'HEALTHYTOUCH SPIRIT 500ML', 'PD1538', NULL, NULL, 90.00, 110.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1538, 5, 'CLASSIC HERBAL BAR SOAP 1KG', '6161101660709', 'C128', NULL, 148.00, 170.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:49:03'),
(1539, 1, 'FESTIVAL FOOD COLOURING 10G', '6164000066504', 'C128', NULL, 21.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:36:30'),
(1540, 3, 'UFRESH JUICE', '6034000117783', 'C128', -1, 15.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 16:20:31'),
(1541, 4, 'SUPA  SOFT TOILET TISSUE', 'PD1542', NULL, NULL, 21.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1542, 7, 'NEPTUNE  JUMBO GREEN TISSUE', '6161101661188', 'C128', NULL, 123.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:19:44'),
(1543, 5, 'DOFFI PURPLE 1KG', '6203012970888', 'C128', NULL, 0.00, 0.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:16:19'),
(1544, 11, 'PALATINATE PENCIL  HB PK', 'PD1545', NULL, NULL, 70.00, 100.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1545, 11, 'PALATINATE HB PENCIL', 'PD1546', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1546, 11, 'NATARAJI SILVER PENCILS', '8901324037555', 'C128', NULL, 9.00, 15.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:47:32'),
(1547, 11, 'NATARAJ SILVER PENCIL PK', 'PD1548', NULL, NULL, 110.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1548, 8, 'WOODEN TOOTHPIC', 'PD1549', NULL, NULL, 17.00, 25.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1549, 8, 'SONAPLAST', 'PD1550', NULL, NULL, 5.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1550, 8, 'ENO TABLET', 'PD1551', NULL, NULL, 14.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1551, 5, 'OMO BLEACH REGULAR 70ML', '6161115170546', 'C128', NULL, 23.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:32:54'),
(1552, 1, 'ZESTA SOY SAUCE 700ML', '6162000020335', 'C128', NULL, 219.00, 300.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:22:11'),
(1553, 1, 'ROYCO CUBE CHICKEN FLAVOUR', '6161100604537', 'C128', NULL, 110.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:56:30'),
(1554, 1, 'ROYCO KNORR CUBE BEEF FLAVOUR', '6161100600249', 'C128', NULL, 69.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:59:23'),
(1555, 1, 'ROYCO MUCHUZI MIX 7OG', '6161109722010', 'C128', NULL, 35.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:54:18'),
(1556, 12, 'ORGAZ  BURNER', '8697435550174', 'C128', NULL, 140.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:25:29'),
(1557, 12, 'PRIMUS  BRULEUR BURNER', 'PD1558', NULL, NULL, 250.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1558, 12, 'SUN GAS', 'PD1559', NULL, NULL, 150.00, 200.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1559, 7, 'H R GAS BURNER', 'PD1560', NULL, NULL, 250.00, 300.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1560, 1, 'CERELAC WHEAT &BANANA 50G', '6161106962181', 'C128', NULL, 83.00, 95.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:49:51'),
(1561, 5, 'OMO 40G', '6166000108024', 'C128', NULL, 6.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 10:37:40'),
(1562, 1, 'INTER VALLO SPAGHETT 500G', '8690828637964', 'C128', NULL, 105.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:56:55'),
(1563, 1, 'QUEEN SPAGHRTT 500G', '8690828629631', 'C128', NULL, 100.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:57:24'),
(1564, 1, 'NOLLA  SPAGHETT  500G', '6224009197064', 'C128', NULL, 66.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:56:15'),
(1565, 1, 'SPECIAL  GOLD  SPAGHETT 500G', 'PD1566', NULL, NULL, 64.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1566, 1, 'ORCHID VALLEY  TROPICAL250ML', 'PD1567', NULL, NULL, 44.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1567, 3, 'ORCHID VALLEY APPLE 250ML', 'PD1568', NULL, NULL, 44.00, 60.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1568, 3, 'ORCHID VALLEY GUAVA 250ML', '6161101063784', 'C128', NULL, 44.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:24:01'),
(1569, 10, 'LATO GROW PINEAPPLE 125ML', 'PD1570', NULL, NULL, 30.00, 40.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1570, 10, 'LATO GROW  PINEAPPLE 250ML', '6164005005089', 'C128', NULL, 56.00, 75.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:26:56'),
(1571, 7, 'PEPSODENT CAVITY FIGHTER 65G', '8934839128289', 'C128', -1, 75.00, 100.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 01:13:21'),
(1572, 7, 'PEPSODENT  HERBAL  65G', '8934839129699', 'C128', NULL, 75.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:15:56'),
(1573, 1, 'PEPTANG CHOMA  SAUCE 400G', '6161101061391', 'C128', NULL, 130.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:40:10'),
(1574, 10, 'MOLO MILK 500ML', '6161102794694', 'C128', NULL, 45.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:17:28'),
(1575, 1, 'PEPTANG TOMATO SAUCE 400G', '6008835000015', 'C128', NULL, 98.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:41:23'),
(1576, 1, 'PEPTANG HOT & SWEET SAUCE 250G', '6161101060264', 'C128', NULL, 85.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:40:49'),
(1577, 1, 'PEPTANG HABANERO SAUCE 150G', '6161101063890', 'C128', NULL, 62.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:43:18'),
(1578, 3, 'PEP PINEAPPLE DRINK 2LITRES', 'PD1579', NULL, NULL, 315.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1579, 3, 'PEP COCOPINE DRINK 2LITRES', 'PD1580', NULL, NULL, 315.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1580, 3, 'PEP MANGO DRINK 2LITRES', '6161101065511', 'C128', NULL, 315.00, 350.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:23:42'),
(1581, 3, 'PEP LEMON DRINK 2 LITRES', 'PD1582', NULL, NULL, 315.00, 350.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1582, 3, 'PEP PASSION DRINK 2LTRS', '6161101065757', 'C128', NULL, 315.00, 350.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:22:59'),
(1583, 3, 'PEP MIXED  FRUIT DRINK  2LITRES', '6161101065634', 'C128', NULL, 315.00, 350.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:22:10'),
(1584, 3, 'PEP PINEAPPLE DRINK 1LITRE', 'PD1585', NULL, NULL, 163.00, 190.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1585, 3, 'PEP MIXED FRUIT DRINK 1LITRE', '6161101065610', 'C128', NULL, 163.00, 190.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:19:50'),
(1586, 3, 'PEP PASSION DRINK 1 LITRE', 'PD1587', NULL, NULL, 163.00, 190.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1587, 3, 'PEP LEMON DRINK 1 LITRE', 'PD1588', NULL, NULL, 163.00, 190.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1588, 3, 'PEP COCKTAIL DRINK 1LITRE', '6161101065672', 'C128', NULL, 163.00, 190.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:26:56'),
(1589, 3, 'PEP MANGO DRINK 1 LITRE', '6161101065498', 'C128', NULL, 163.00, 190.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:27:23'),
(1590, 2, 'ROLLISTIC WAFER ROLL', 'PD1591', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1591, 2, 'GRAPE CANDY ', 'PD1592', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1592, 2, 'FANTA BABYCANDY18G', 'PD1593', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1593, 1, 'FAMILA PURE WIMBI 1KG', '6008792000134', 'C128', NULL, 152.00, 190.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:46:20'),
(1594, 1, 'FAMILA PURE WIMBI 500G', '6161100450134', 'C128', -1, 75.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 13:09:54'),
(1595, 1, 'BIRYANLOCAL1KG', 'PD1596', NULL, NULL, 108.00, 140.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1596, 1, 'BIRYANLOCAL1/2KG', 'PD1597', NULL, NULL, 54.00, 70.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1597, 1, 'BIRYANLOCAL1/4KG', 'PD1598', NULL, NULL, 27.00, 35.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1598, 5, 'ZENTABARSOAP1KG', '6161110130675', 'C128', NULL, 145.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:46:23'),
(1599, 6, 'VERSMAN ACTIVE', '61604117', 'C128', NULL, 200.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 19:18:31'),
(1600, 4, 'MYA+SANITARYPADS', '6972329478515', 'C128', NULL, 55.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:44:40'),
(1601, 1, 'TROPICAL HEAT SALTED 50G', '6161100910966', 'C128', NULL, 45.00, 65.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:24:08'),
(1602, 11, 'BICBALLPENORANGE', 'PD1603', NULL, NULL, 20.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1603, 11, 'HARDCOVERA6160PGS', '6161102782813', 'C128', NULL, 35.00, 55.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 15:14:20'),
(1604, 6, 'VASELINECOCOARADIANT100ML', '6161115174087', 'C128', NULL, 138.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:22:19'),
(1605, 6, 'VASELINEDRYSKINREPAIR100ML', '6161115174070', 'C128', NULL, 138.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:10:30'),
(1606, 10, 'LATOMILK250ML', '6164002812116', 'C128', NULL, 35.00, 45.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:36:23'),
(1607, 5, 'OMOWASHINGPOWDER40G', 'PD1608', NULL, NULL, 15.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1608, 2, 'OREO ORINGINAL 128G', '7622201699031', 'C128', NULL, 133.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:11:23'),
(1609, 2, 'OREO CHOCOLATE 128G', '7622201698997', 'C128', NULL, 133.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:12:16'),
(1610, 2, 'OREO GOLDEN 128G', '7622201699383', 'C128', NULL, 133.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:10:44'),
(1611, 2, 'OREO ORIGINAL 36.8', '7622201384869', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:08:52'),
(1612, 2, 'OREO CHOCOLATE COATED 36.8G', '7622201384821', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:07:54'),
(1613, 2, 'OREO CHOCOLATE 55.2G', '7622202018008', 'C128', NULL, 55.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:06:27'),
(1614, 2, 'CADBURY DAIRY BUBBLY CHOCOLATE 28G', 'PD1615', NULL, NULL, 70.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1615, 2, 'CADBURYTOPDECKMINTCHOCOLATE80G', 'PD1616', NULL, NULL, 202.00, 230.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1616, 2, 'CADBURY  FRUIT & NUT 80G', '6001065601014', 'C128', NULL, 202.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:43:38'),
(1617, 2, 'CADBURY TOP DECK CHOCOLATE 80G', '6001065601090', 'C128', NULL, 202.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:38:52'),
(1618, 2, 'CADBURY CREAMY WHITE 80G', '6001065601038', 'C128', NULL, 202.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:51:25'),
(1619, 2, 'CADBURY MINT CRISP 80G', '6001065601076', 'C128', NULL, 202.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:47:59'),
(1620, 2, 'CADBURY ROM&RAISING CHOCOLATE  80G', 'PD1621', NULL, NULL, 202.00, 230.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1621, 2, 'CADBURYFRUIT&NUT80G', 'PD1622', NULL, NULL, 202.00, 230.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1622, 2, 'CADBURY WHOLE NUT  80G', '6001065601007', 'C128', NULL, 202.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:49:06'),
(1623, 5, 'DOWNY SUNRISE FRESH 300ML', '8700216394703', 'C128', NULL, 168.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 23:15:55'),
(1624, 5, 'DOWNY SWEETELEGANCE 300ML', '8700216394536', 'C128', NULL, 168.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 23:17:07'),
(1625, 5, 'DOWNYPOUCHLAVENDERCALM300ML', '8700216394727', 'C128', NULL, 168.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 23:12:00'),
(1626, 2, 'TROPICAL HEAT CHEVDA 50G', '6161100910478', 'C128', NULL, 59.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:29:18'),
(1627, 2, 'TROPICAL  HEAT CLOVES 50G', '6161100911741', 'C128', NULL, 213.00, 240.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:00:29'),
(1628, 5, 'USHINDI- BAR SOAP800G', '6161106612680', 'C128', NULL, 175.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 00:28:42'),
(1629, 5, 'GEISHA ALOEVERA SOAP 90G', '6161115172359', 'C128', NULL, 45.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:44:40'),
(1630, 5, 'GEISHACOCONUT&HONEYSOAP90G', '6161115172366', 'C128', NULL, 45.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:47:10'),
(1631, 5, 'GEISHALEMON&HONEYSOAP90G', '6161115172304', 'C128', NULL, 45.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:34:22'),
(1632, 5, 'GEISHAFRAGRANTROSE&HONEY90G', '6161115172311', 'C128', NULL, 45.00, 60.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 20:36:03'),
(1633, 12, 'ELECRICAL INSULATING  TAPE', 'PD1634', NULL, NULL, 21.00, 50.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1634, 11, 'POWER OFFICE  GLUE 90G', '6164000108501', 'C128', NULL, 16.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:03:40'),
(1635, 4, 'SOFTCARE PREMIUM  DIAPER MEDIUM 42PCS', 'PD1636', NULL, NULL, 600.00, 680.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1636, 4, 'SOFTCARE  PREMIUM DIAPERS 40PCS', '6164004723410', 'C128', NULL, 600.00, 680.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 21:21:02'),
(1637, 11, 'GEL SCHOOL RULER', 'PD1638', NULL, NULL, 11.00, 30.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1638, 11, 'NATRAJ RUBBER', '8901324220056', 'C128', NULL, 2.00, 10.00, NULL, 'PIECES', 99, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 22:01:40'),
(1639, 2, 'XXL PINPOP LOLLIPOP', 'PD1640', NULL, NULL, 8.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1640, 2, 'BIG HAPPY LEMONFLAVOUR', '6164002740372', 'C128', -1, 7.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 02:23:08'),
(1641, 2, 'BIG HAPPYCHOCOVANNILA FLAVOUR', '6164002740518', 'C128', NULL, 7.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:35:26'),
(1642, 2, 'BISCAPI COCOA WAFER', 'PD1643', NULL, NULL, 10.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1643, 2, 'TAWTAW COCOA', 'PD1644', NULL, NULL, 9.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1644, 2, 'FASTER STRAWBERRY FLAVOUR', 'PD1645', NULL, NULL, 9.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1645, 2, 'TATBAR  CHOCOLATE', 'PD1646', NULL, NULL, 6.00, 15.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1646, 2, 'DORA FRUIT BALLS', 'PD1647', NULL, NULL, 3.00, 5.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1647, 2, 'WINDMILL  LOLLIPOP 12G', 'PD1648', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1648, 5, 'KIBUYU CHENZA WASHING BAR 1KG', '6161100908277', 'C128', NULL, 168.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-17 22:41:14'),
(1649, 7, 'KIWI BROWN SHOE POLISH 32G/40ML', '6161108970061', 'C128', NULL, 108.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:48:12'),
(1650, 5, 'SEDOSE SHOWER GEL 400ML', 'PD1651', NULL, NULL, 210.00, 270.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1651, 5, 'SEDOSO SHOWER GEL ALOE VERA 400ML', '792649123966', 'C128', NULL, 210.00, 270.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:14:28'),
(1652, 6, 'SEDOSO  COCOA BUTTER 400ML', '769503877297', 'C128', NULL, 160.00, 220.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:32:43'),
(1653, 6, 'SEDOSO ALOE VERA 400ML', '769503877259', 'C128', NULL, 160.00, 220.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:32:00'),
(1654, 6, 'SEDOSO GLYCERINE 400ML', 'PD1655', NULL, NULL, 160.00, 220.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1655, 6, 'SEDOSO COCOA BUTTER 200ML', 'PD1656', NULL, NULL, 90.00, 130.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1656, 6, 'SEDOSO ALOE VERA 200ML', '769503877235', 'C128', NULL, 90.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:34:18'),
(1657, 6, 'SEDOSO GLYCERINE 200ML', '769503877150', 'C128', NULL, 90.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:35:02'),
(1658, 6, 'SEDOSO SHOWER GEL ALOE 200ML', '745178423557', 'C128', NULL, 105.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:06:04'),
(1659, 3, 'COFFEEBEE COFFEE 1.6G', '796554355009', 'C128', NULL, 6.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 11:54:42'),
(1660, 2, 'HILWA  WHITE OATS 1KG', '9557366570810', 'C128', NULL, 200.00, 350.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:33:20'),
(1661, 2, 'MILANO VANILLA COCOA', '6261149044384', 'C128', NULL, 30.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 10:27:31'),
(1662, 2, 'FESTIVAL CLEAR VANILLA ESSENCE 50ML', '6009610390659', 'C128', NULL, 100.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:11:40'),
(1663, 2, 'VANILLA ESSENCE CLOVERS 500ML', '6008677002628', 'C128', NULL, 180.00, 220.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:15:47'),
(1664, 1, 'COCONUT  MILK ELEPHANT & SUN 400ML', '8851011322948', 'C128', NULL, 180.00, 250.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:44:37'),
(1665, 7, 'COLGATE 2IN1 TOOTHBRUSH', '6001067001485', 'C128', -1, 118.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 17:36:05'),
(1666, 7, 'COLGATE SINGLE DOUBLEACTION TOOTHBRUSH', 'PD1667', NULL, NULL, 65.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1667, 3, 'PEP MANGO DRINK 500ML', '6161101064781', 'C128', NULL, 65.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:36:42'),
(1668, 3, 'PEP APPLE DRINK 500ML', 'PD1669', NULL, NULL, 65.00, 90.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1669, 3, 'PEP TROPICAL DRINK 500ML', '6167701064817', 'C128', NULL, 65.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 09:42:47'),
(1670, 2, 'FUNTIME SNACKS 10G', '792382623914', 'C128', NULL, 8.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 13:32:34'),
(1671, 1, 'NDOVU ALL PURPOSE FLOUR 500ML', '6161103620114', 'C128', -2, 44.00, 55.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-21 15:05:35'),
(1672, 3, 'ORCHID VALLEY MANGO 1LITRE', '6161101060356', 'C128', NULL, 205.00, 260.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:49:39'),
(1673, 3, 'ORCHID VALLEY APPLE 1LITRE', '6161101060387', 'C128', NULL, 205.00, 260.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:50:38'),
(1674, 3, 'ORCHID VALLEY PASSION 1LITRE', '6161101060394', 'C128', NULL, 205.00, 260.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:51:21'),
(1675, 2, 'TROPICAL HEAT  WHITE PEPPER 50G', '6161100913103', 'C128', NULL, 177.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:02:04'),
(1676, 1, 'TROPICAL HEAT CLOVES SPICE 50G', 'PD1677', NULL, NULL, 213.00, 240.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1677, 7, 'TIARA SOFT TISSUE', '6161114908997', 'C128', NULL, 40.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:02:48'),
(1678, 7, 'TIARA SOFT SERVIETTES', '6161114909017', 'C128', NULL, 86.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:32:34'),
(1679, 4, 'SOFTCARE WET WIPES 40PCS', '6166000122174', 'C128', NULL, 50.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:38:16'),
(1680, 2, 'PARLE FAMILY BISCUITS 72G', '8901719921797', 'C128', NULL, 19.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:47:45'),
(1681, 5, 'ROBERTS ANTISEPTIC DISINFECTANT 50ML', '6008879087805', 'C128', NULL, 90.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:37:03'),
(1682, 5, 'ROBERTS ANTISEPTIC LIQUID 125ML', '6161102000160', 'C128', NULL, 0.00, 0.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:38:28'),
(1683, 2, 'YEGO GLUCOSE ENERGY BISCUIT 200G', '6164000242212', 'C128', NULL, 52.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 12:38:23'),
(1684, 5, 'SEDOSO BLEACH REGULAR 250ML', '710497392709', 'C128', NULL, 30.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 01:35:51'),
(1685, 6, 'SEDOSO  GLYCERINE 20ML', '769503877167', 'C128', NULL, 60.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:38:45'),
(1686, 6, 'SEDOSO SHOWER GEL MEN 200ML', '745178810517', 'C128', NULL, 66.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 04:18:19'),
(1687, 6, 'SEDOSO COCOA BUTTER 200ML', '769503877273', 'C128', NULL, 60.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:36:10'),
(1688, 6, 'SEDOSO  ALOE VERA 120ML', '769503877198', 'C128', NULL, 60.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 06:46:01'),
(1689, 6, 'SEDOSO COCONUT OIL 65ML', '745125375816', 'C128', NULL, 53.00, 70.00, NULL, 'PIECE', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 02:38:29'),
(1690, 6, 'SEDOSO MOULDING WAX GEL 70G', '769503877143', 'C128', NULL, 110.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:12:06'),
(1691, 6, 'SEDOSO STYLING GEL FIRM HOLD 80G', '745125375953', 'C128', NULL, 66.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:10:46'),
(1692, 6, 'SEDOSO STYLING GEL NON FLAKING 80G', '792649528129', 'C128', NULL, 77.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 07:09:38'),
(1693, 5, 'SEDOSO HANDWASH ROSE 300ML', '710535499322', 'C128', NULL, 100.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:12:21'),
(1694, 5, 'SEDOSO HANDWASH LAVENDER 300ML', '745114896377', 'C128', NULL, 100.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:14:13'),
(1695, 5, 'SEDOSO HANDWASH LEMON & CITRUS 300ML', '745114593719', 'C128', NULL, 100.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:16:48'),
(1696, 5, 'SEDOSO HANDWASH ORANGE 300ML', '745114091178', 'C128', NULL, 100.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 00:18:02'),
(1697, 5, 'SEDOSO HANDWASH STRAWBERRY 300ML', 'PD1698', NULL, NULL, 100.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1698, 5, 'SEDOSO HANDWASH APRIOT 300ML', 'PD1699', NULL, NULL, 100.00, 150.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1699, 7, 'HANAN PREMIUM TISSUE 8 ROLLS', '6164000242502', 'C128', NULL, 450.00, 500.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 08:28:01'),
(1700, 2, 'PEPTANG PEANUT BUTTER 250G(CREAMY)', '6161101063616', 'C128', NULL, 190.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:05:05'),
(1701, 2, 'PEPTANG PEANUT BUTTER CRUNCHY 250G', '6161101063623', 'C128', NULL, 190.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 14:04:20'),
(1702, 2, 'KIKKOMAN SOYSAUCE 30ML', '4901515000621', 'C128', NULL, 30.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 12:47:40'),
(1703, 2, 'KITKAT COCOA PLAN CHOCOLATE 41.5G', '40052458', 'C128', NULL, 102.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-20 11:29:39'),
(1704, 2, 'OMIGO SANDWICH BISCUIT 5G', 'PD1705', NULL, NULL, 12.00, 20.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1705, 1, 'PEMBE HOME BAKING FLOUR 2KG', '6009627050034', 'C128', NULL, 159.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, 1, NULL, NULL, '2024-06-18 13:23:11'),
(1706, 2, 'CEREALCHOCOLATE', 'PD1707', NULL, NULL, 6.00, 10.00, NULL, 'PIECE', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(1707, 5, 'ZURI SPORT 200g', '6161100902503', 'C128', NULL, 70.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 03:00:44', '2024-06-17 21:18:55'),
(1708, 5, 'SAWA CHOCOLATE 225G', '6161106613588', 'C128', NULL, 70.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 03:11:00', '2024-06-18 03:12:10'),
(1709, 5, 'SAWA LEMON+HONEY', '6161106613427', 'C128', NULL, 70.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 19:48:09', '2024-06-17 19:50:09'),
(1710, 5, 'SAWA STRAWBERRY 225G', '6161106612567', 'C128', NULL, 70.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 19:53:23', '2024-06-17 19:54:16'),
(1711, 5, 'SAWA STRAWBERRY 70G', '6161106614615', 'C128', NULL, 40.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 20:07:39', '2024-06-17 20:08:25'),
(1712, 5, 'SAWA HERBAL 70G', '6161106611751', 'C128', NULL, 40.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 20:11:40', '2024-06-17 20:12:34'),
(1713, 5, 'GEISHACOCONUT&HONEY200G', 'IT01713', 'C128', NULL, 102.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 20:28:34', '2024-06-17 20:28:34'),
(1714, 5, 'GEISHA ALOEVERA +HONEY 200G', '6161115172571', 'C128', NULL, 102.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 20:31:36', '2024-06-17 20:32:03'),
(1715, 5, 'DOVE ORIGINAL135G', '7501238891192', 'C128', NULL, 150.00, 240.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 20:40:43', '2024-06-17 20:41:04'),
(1716, 5, 'DOVE PINK135G', 'IT01716', 'C128', NULL, 150.00, 220.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 20:42:04', '2024-06-17 20:42:04'),
(1717, 5, 'MILELE ALOE SOAP 125g', '6161117772366', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 20:52:26', '2024-06-17 20:52:57'),
(1718, 5, 'MILELE SENSUAL SOAP 125g', '6161117772380', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 20:54:03', '2024-06-17 20:54:31'),
(1719, 5, 'MILELE MILK COCONUT 250g', 'IT01719', 'C128', NULL, 75.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 20:58:30', '2024-06-17 20:58:30');
INSERT INTO `products` (`id`, `category_id`, `product_name`, `product_code`, `product_barcode_symbology`, `product_quantity`, `product_cost`, `product_price`, `wholesale_price`, `product_unit`, `product_stock_alert`, `product_order_tax`, `product_tax_type`, `product_note`, `supplier_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1720, 5, 'LUX ROSE 172G', '8961014249361', 'C128', NULL, 110.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 21:02:36', '2024-06-17 21:04:56'),
(1721, 5, 'CUSSONS BABY SOFT 100G', '6161102004960', 'C128', NULL, 90.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 21:08:51', '2024-06-17 21:09:52'),
(1722, 5, 'USHINDI PLUS 175G', '6161106612727', 'C128', NULL, 34.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 21:38:37', '2024-06-17 21:38:54'),
(1723, 5, 'LANZO MENTHOL 200G', 'IT01723', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 21:48:54', '2024-06-17 21:48:54'),
(1724, 5, 'LANZO MENTHOL 100G', '6161101662338', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 21:51:01', '2024-06-17 21:51:46'),
(1725, 5, 'LANZO ANTI-BACTERIAL SOAP 200g', '6161101662451', 'C128', NULL, 75.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 21:53:38', '2024-06-17 21:56:20'),
(1726, 5, 'LANZO COCONUT 200G', '6161101662413', 'C128', NULL, 75.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 21:59:49', '2024-06-17 22:00:22'),
(1727, 5, 'DETREX CITRONELLA  80G', '6161106614639', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 22:08:46', '2024-06-17 22:09:13'),
(1728, 5, 'DETREX PINE DROPS 80G', '6161106614646', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 22:12:34', '2024-06-17 22:14:29'),
(1729, 5, 'DETREX MINT 80G', '6161106614622', 'C128', NULL, 40.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 22:13:07', '2024-06-17 22:13:59'),
(1730, 5, 'SAVANAH BEAUTIFUL 120G', '6291003164330', 'C128', NULL, 40.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 22:19:37', '2024-06-17 22:20:04'),
(1731, 5, 'SAVANNAH 4 PACK BLOOM 400G', '6291003612053', 'C128', NULL, 90.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 22:26:28', '2024-06-17 22:27:08'),
(1732, 5, 'DOWNY LUXURY PERFUME 280G', '8001090596451', 'C128', NULL, 220.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 23:25:50', '2024-06-17 23:26:43'),
(1733, 5, 'DOWNY SUNRISE FRESH 20ML', '8700216394765', 'C128', NULL, 12.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 23:32:53', '2024-06-17 23:43:49'),
(1734, 5, 'DOWNY LAVENDA 20G', '8700216394567', 'C128', NULL, 12.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 23:33:55', '2024-06-17 23:35:48'),
(1735, 5, 'DOWNY SWEET ELEGANCE 20G', '8700216394666', 'C128', NULL, 12.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 23:34:35', '2024-06-17 23:36:17'),
(1736, 5, 'STAR-SOFT SPRING 200ML', '6001067000341', 'C128', NULL, 110.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 23:47:55', '2024-06-17 23:52:38'),
(1737, 5, 'STAR-SOFT SPRING 400ML', '6001067000389', 'C128', NULL, 180.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 23:48:30', '2024-06-17 23:53:21'),
(1738, 5, 'STAR-SOFT  SPRING 750ML', '6001067000372', 'C128', NULL, 300.00, 350.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 23:49:25', '2024-06-17 23:51:27'),
(1739, 5, 'STAR-SOFT LAVENDA 750ML', '6001067000426', 'C128', NULL, 300.00, 350.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 23:50:22', '2024-06-17 23:51:54'),
(1740, 5, 'STAR-SOFT  LAVENDA 400ML', '6001067000419', 'C128', NULL, 190.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-17 23:54:39', '2024-06-17 23:54:57'),
(1741, 5, 'ERIPRIDE CARNATION 500ML', '6164003349253', 'C128', NULL, 130.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 00:00:57', '2024-06-18 00:07:28'),
(1742, 5, 'ERIPRIDE COCONUT 500ML', '6164003349918', 'C128', NULL, 130.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 00:01:52', '2024-06-18 00:08:21'),
(1743, 5, 'ERIPRIDE OCEAN BREEZE 500ML', '6164003349840', 'C128', NULL, 130.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 00:02:32', '2024-06-18 00:06:11'),
(1744, 5, 'ERIPRIDE APRICOT 500ML', '6164003349239', 'C128', NULL, 130.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 00:03:11', '2024-06-18 00:06:48'),
(1745, 5, 'ERIPRIDE STRAWBERRY 500ML', '6164003349246', 'C128', NULL, 130.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 00:03:52', '2024-06-18 00:05:44'),
(1746, 5, 'IVY MIDNIGHT JASME', '6291003616433', 'C128', NULL, 130.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 00:05:14', '2024-06-18 00:09:06'),
(1747, 5, 'SUNLIGHT D/WASH STRAWBERRY 400ML', '6164004801675', 'C128', NULL, 140.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 00:24:38', '2024-06-18 00:26:11'),
(1748, 5, 'SUNLIGHT D/WASH LEMON 400ML', '6161109723840', 'C128', NULL, 140.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 00:25:22', '2024-06-18 00:27:01'),
(1749, 5, 'VIMLEMON 1KG', '6161100605817', 'C128', NULL, 180.00, 240.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 00:47:47', '2024-06-18 00:48:44'),
(1750, 5, 'VIMLEMON 500G', '6161100604063', 'C128', NULL, 9.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 00:53:29', '2024-06-18 00:54:34'),
(1751, 5, 'VELVEX COTTON WOOL 400G', '6161100761452', 'C128', NULL, 150.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 01:07:19', '2024-06-18 01:08:49'),
(1752, 5, 'OMO BLEACH LAVENDER 70ML', '6161115175183', 'C128', NULL, 21.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 01:34:05', '2024-06-18 01:34:49'),
(1753, 5, 'USHINDI DISHWASHING ORANGE 200G', 'IT01753', 'C128', NULL, 69.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 01:52:24', '2024-06-18 01:53:07'),
(1754, 7, 'PEPSODENT CAVITY FIGHTER 30G', '8934839129439', 'C128', -1, 37.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 02:20:34', '2024-06-21 01:13:21'),
(1755, 5, 'BEULA  CREAM CONDITIONER1L', '6164004648515', 'C128', NULL, 160.00, 200.00, NULL, '5', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 03:18:53', '2024-06-18 03:19:30'),
(1756, 5, 'BEULA CONDITIONER PINK500ML', '6164004648119', 'C128', NULL, 0.00, 0.00, NULL, '5', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 03:23:52', '2024-06-18 03:24:45'),
(1757, 5, 'BEULAPINKCONDITIONER', 'I6164004648119', 'C128', NULL, 110.00, 159.00, NULL, '1', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:35:31', '2024-06-18 04:41:00'),
(1758, 5, '.BEULA SHAMPOOCRYSTAL250ML', '6164000838965', 'C128', NULL, 60.00, 80.00, NULL, '4', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:45:48', '2024-06-18 04:46:27'),
(1759, 5, 'BAMSICRYSTALSHAMPOO500ML', '6164000838972', 'C128', NULL, 110.00, 150.00, NULL, '3', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:51:05', '2024-06-18 04:54:58'),
(1760, 5, 'BEULAWHITECONDITIONER', '6164004648454', 'C128', NULL, 120.00, 150.00, NULL, '1', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:58:17', '2024-06-18 04:58:48'),
(1761, 6, 'BAMSI APPLE FRESH SHAMPOO 250ML', '6164000838941', 'C128', NULL, 55.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:03:12', '2024-06-18 04:03:49'),
(1762, 6, 'SEDOSO SHOWER GEL CARAMEL 200ML', '745178423540', 'C128', NULL, 110.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:11:37', '2024-06-18 04:12:03'),
(1763, 6, 'SEDOSO SHOWER  GEL ALMOND 400ML', '792649123935', 'C128', NULL, 210.00, 270.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:20:44', '2024-06-18 04:21:12'),
(1764, 6, 'SEDOSO SHOWER GEL ALOE 750ML', '796554464749', 'C128', NULL, 290.00, 400.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:23:57', '2024-06-18 04:24:21'),
(1765, 6, 'SEDOSO SHOWER  GEL ALMOND 750ML', '796554464756', 'C128', NULL, 290.00, 400.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:25:26', '2024-06-18 04:25:44'),
(1766, 6, 'SEDOSO SHOWER GEL CARAMEL 750ML', '796554464732', 'C128', NULL, 290.00, 400.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:26:27', '2024-06-18 04:26:43'),
(1767, 6, 'SEDOSO FOR MEN 750ML', '796554464763', 'C128', NULL, 290.00, 400.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:27:39', '2024-06-18 04:28:02'),
(1768, 6, 'CUSSONS BABY UNPERFUMED 100ML', '6008879012357', 'C128', NULL, 130.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:38:57', '2024-06-18 04:39:17'),
(1769, 6, 'CUSSONS BABY UNPERFUMED 200ML', '6161102006834', 'C128', NULL, 240.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:41:09', '2024-06-18 04:41:26'),
(1770, 6, 'BEULA BABY JELLY UNPERFUMED 75G', '6161115200007', 'C128', NULL, 62.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 04:58:35', '2024-06-18 04:59:12'),
(1771, 6, 'NICE AND LOVELY MILK CREAM 400ML', '6161110963624', 'C128', NULL, 220.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 05:21:11', '2024-06-18 05:21:58'),
(1772, 6, 'NICE AND LOVELY CARROT OIL 400ML', '6161110963747', 'C128', NULL, 220.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 05:23:06', '2024-06-18 05:23:27'),
(1773, 6, 'NICE AND LOVELY ALOE VERA 400ML', '6161110963587', 'C128', NULL, 220.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 05:24:30', '2024-06-18 05:24:50'),
(1774, 6, 'NICE AND LOVELY GLYCERINE 400ML', '6161110963549', 'C128', NULL, 220.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 05:26:01', '2024-06-18 05:26:19'),
(1775, 6, 'NICE AND LOVELY FOR MEN 400ML', '6161110962702', 'C128', NULL, 220.00, 280.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 05:27:15', '2024-06-18 05:27:32'),
(1776, 6, 'NICE AND LOVELY ALOE VERA 200ML', '6161110965468', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 05:32:13', '2024-06-18 05:32:57'),
(1777, 6, 'NICE AND LOVELY AVOCDO 200ML', '6161110963655', 'C128', NULL, 120.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 05:34:03', '2024-06-18 05:34:24'),
(1778, 6, 'NICE & LOVELY ALOE VERA100ML', '6161110963563', 'C128', NULL, 120.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 05:40:10', '2024-06-18 05:40:25'),
(1779, 6, 'NICE & LOVELY GLYCERINE 100ML', '6161110963525', 'C128', NULL, 120.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 05:41:32', '2024-06-18 05:42:16'),
(1780, 6, 'NICE & LOVELY FOR MEN 100ML', 'I6161110962658', 'C128', NULL, 120.00, 140.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 05:43:12', '2024-06-18 05:43:39'),
(1781, 6, 'ZOE GLYCERINE 400ML', '6161104340066', 'C128', NULL, 200.00, 260.00, NULL, 'P', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 05:54:30', '2024-06-18 05:54:55'),
(1782, 6, 'ZOE STARLIT SKY 400ML', '6161104343630', 'C128', NULL, 200.00, 260.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 05:56:03', '2024-06-18 05:56:32'),
(1783, 6, 'ZOE VELVET  CARAMEL 400ML', '6161104343418', 'C128', NULL, 200.00, 260.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 05:57:24', '2024-06-18 05:57:40'),
(1784, 6, 'ZOE COCOA BUTTER 200ML', '6161104340059', 'C128', NULL, 110.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 06:01:21', '2024-06-18 06:03:05'),
(1785, 6, 'ZOE SUMMER NIGHTS 200ML', '6161104344477', 'C128', NULL, 110.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 06:04:47', '2024-06-18 06:05:13'),
(1786, 6, 'ZOE  MEN 200ML', '6161104343258', 'C128', NULL, 110.00, 160.00, NULL, 'P', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 06:06:36', '2024-06-18 06:06:56'),
(1787, 6, 'GIRL FRIEND FANTASY LANOLIN 500ML', '6001374034046', 'C128', NULL, 2.00, 2.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 06:15:39', '2024-06-18 06:16:54'),
(1788, 6, 'GIRL FRIEND HONEY TWIST 500ML', '6001374034053', 'C128', NULL, 180.00, 210.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 06:18:15', '2024-06-18 06:18:42'),
(1789, 6, 'SEDOSO COCOA BUTTER 120ML', '769503877204', 'C128', NULL, 65.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 06:54:48', '2024-06-18 06:55:08'),
(1790, 6, 'RADIANT ANTI-DANDRUFF 60G', '6162400124190', 'C128', NULL, 90.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 07:20:29', '2024-06-18 07:20:47'),
(1791, 6, 'BEULA MASSAGE OIL EUCALYPTUS 500ML', '6164004700015', 'C128', NULL, 250.00, 300.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 07:38:25', '2024-06-18 07:39:06'),
(1792, 4, 'ROSY  WHITE', '6009614480462', 'C128', NULL, 30.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 08:06:04', '2024-06-18 08:06:41'),
(1793, 4, 'NETA  NETA  TISSUE', '745125578224', 'C128', NULL, 15.00, 20.00, NULL, '5', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 08:10:25', '2024-06-18 08:11:33'),
(1794, 4, 'NEPTUNE  JUMBO PURPLETISSUE', '6161101661171', 'C128', NULL, 123.00, 150.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 08:21:29', '2024-06-18 08:22:24'),
(1795, 4, 'TIMMY JUMBO ROLL', '6166000110652', 'C128', NULL, 70.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 08:24:44', '2024-06-18 08:25:05'),
(1796, 4, 'SOFTCARE DIAPERS SMALL 10PCS', '6166000121931', 'C128', NULL, 130.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 08:54:30', '2024-06-20 21:10:50'),
(1797, 5, 'ARIEL FRESH LAVENDAR 500G', '8001090123640', 'C128', NULL, 200.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 09:07:19', '2024-06-18 09:08:36'),
(1798, 5, 'KLEESOFT ROSE PERFUME 500G', '6203012970789', 'C128', NULL, 75.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 09:15:16', '2024-06-18 09:17:04'),
(1799, 5, 'SUNLIGHT SPRING SENSETION 500G', '6161109724090', 'C128', NULL, 150.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 09:35:15', '2024-06-18 09:35:58'),
(1800, 5, 'SUNLIGHT TROPICAL 500G', 'IT01800', 'C128', NULL, 150.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 09:40:48', '2024-06-18 09:40:48'),
(1801, 5, 'SUNLIGHT TROPICAL 500G', '6161109724021', 'C128', NULL, 150.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 09:40:49', '2024-06-18 09:42:02'),
(1802, 5, 'SUNLIGHT TROPICAL POWDER 150G', '6161115173028', 'C128', NULL, 43.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 09:50:57', '2024-06-18 09:51:19'),
(1803, 5, 'KLEESOFT ROSE PERFUME 1KG', '6203012970819', 'C128', NULL, 150.00, 180.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 10:13:29', '2024-06-18 10:14:04'),
(1804, 5, 'ARIEL FLORAL CLEAN 70G', '8700216288866', 'C128', NULL, 27.00, 300.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 10:29:29', '2024-06-18 10:29:53'),
(1805, 5, 'SUNLIGHT TROPICAL 80G', '6161115175015', 'C128', NULL, 27.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 10:46:28', '2024-06-18 10:46:52'),
(1806, 1, 'TEA MASALA 10G', '6161100912946', 'C128', NULL, 15.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 11:33:23', '2024-06-18 11:33:46'),
(1807, 3, 'DORMANS CLASSIC 18G', '6161100862005', 'C128', NULL, 0.00, 0.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 11:41:49', '2024-06-18 11:42:54'),
(1808, 1, 'ANGEL DRY YEAST 10G', '6917790006195', 'C128', NULL, 17.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 12:09:49', '2024-06-18 12:10:30'),
(1809, 1, 'FESIVAL VANNILA ESSENCE 5OML', '6164000066672', 'C128', NULL, 100.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 12:13:08', '2024-06-18 12:14:18'),
(1810, 3, 'MELVIS TANGAWIZI 50G', '6161102040807', 'C128', NULL, 23.00, 35.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 12:32:36', '2024-06-18 12:32:55'),
(1811, 1, 'KENYLON TOMATO PASTE 100G', '6162000131062', 'C128', NULL, 60.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 12:46:47', '2024-06-18 12:47:05'),
(1812, 1, '210 MAIZE ,MEAL 1KG', '6164000726187', 'C128', -1, 63.00, 75.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 13:08:42', '2024-06-21 17:04:59'),
(1813, 1, 'FRESH FRI 1L', '6161106610228', 'C128', NULL, 250.00, 400.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 13:34:55', '2024-06-18 13:35:13'),
(1814, 1, 'FRESH FRI 5L', '6161106610259', 'C128', NULL, 1250.00, 1400.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-18 13:38:21', '2024-06-18 13:39:07'),
(1815, 3, 'PEP ORANGE 2LTRS', '6161101065399', 'C128', NULL, 315.00, 350.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 09:25:23', '2024-06-20 09:26:04'),
(1816, 3, 'BRAVA GUAVA JUICE 300ML', '6164004075144', 'C128', -3, 38.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 09:41:32', '2024-06-21 02:04:27'),
(1817, 10, 'BROOKSIDE NATURAL LALA 1000G', '6161107151775', 'C128', -1, 170.00, 185.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 09:55:16', '2024-06-21 16:17:22'),
(1818, 10, 'PROBIOTIC YOGHURT NATURAL 450G', '6161107150372', 'C128', NULL, 148.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 10:05:45', '2024-06-20 10:06:25'),
(1819, 10, 'ILARA YOGHURT PLAIN 500G', '6161107150846', 'C128', NULL, 109.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 10:10:29', '2024-06-20 10:10:46'),
(1820, 10, 'ILARA YOGHURT STRAWBERRY 500G', '6161101000901', 'C128', NULL, 109.00, 130.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 10:11:39', '2024-06-20 10:12:03'),
(1821, 10, 'TUZO YOGHURT STRAWBERRY 200G', '6161107151744', 'C128', -1, 50.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 10:18:17', '2024-06-21 15:04:24'),
(1822, 2, 'LINDO CREAM', '6261149175101', 'C128', NULL, 30.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 10:29:17', '2024-06-20 10:29:33'),
(1823, 2, 'KOYOUM APPLE JUICY 225ML', '6223001870036', 'C128', NULL, 30.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 11:47:21', '2024-06-20 11:47:34'),
(1824, 3, 'ACACIA BLUE RASPBERRY 200ML', '6161110811321', 'C128', NULL, 43.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 11:51:37', '2024-06-20 11:52:07'),
(1825, 2, 'SHORTCAKE BISCUITS', '6161112460893', 'C128', NULL, 3.00, 5.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 11:57:47', '2024-06-20 11:58:01'),
(1826, 4, 'MOLPED HEAVY FLOW PAD', '8690536845217', 'C128', NULL, 80.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 11:59:12', '2024-06-20 12:00:11'),
(1827, 3, 'FANTA PASSION 500ML', '54493353', 'C128', NULL, 65.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 12:03:58', '2024-06-20 12:04:21'),
(1828, 3, 'SCHWEPPES BITTER LEMON 350ML', '90418297', 'C128', NULL, 45.00, 50.00, NULL, 'P', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 12:09:08', '2024-06-20 12:09:36'),
(1829, 2, 'WAVES CHILLI LEMON  CRISPS 30G', '6161100910447', 'C128', NULL, 40.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 12:56:58', '2024-06-20 12:57:22'),
(1830, 2, 'WAVES SALT& VINEGAR CRISPS 30G', '6161100910409', 'C128', -1, 40.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 12:58:49', '2024-06-21 13:34:45'),
(1831, 2, 'WAVES SALTED CRISPS 30G', '6161100910386', 'C128', NULL, 40.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 13:00:36', '2024-06-20 13:01:01'),
(1832, 2, 'WAVES FRUIT CHUTNEY CRISPS 30G', '6161100910461', 'C128', NULL, 40.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 13:02:22', '2024-06-20 13:02:36'),
(1833, 2, 'TROPICAL HEAT SALTED CRIPS 100G', '6161100910973', 'C128', NULL, 90.00, 110.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 13:12:30', '2024-06-20 13:12:43'),
(1834, 2, 'SAFARI PUFFS CHEESE 12G', '6161100916449', 'C128', NULL, 3.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 13:27:35', '2024-06-20 13:28:00'),
(1835, 1, 'ZESTA MIXED FRUIT JAM 200G', '6162000049527', 'C128', NULL, 70.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 14:09:28', '2024-06-20 14:10:04'),
(1836, 11, 'KASUKU A5 120PGS RULED', '6161101536639', 'C128', NULL, 35.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 14:21:08', '2024-06-20 14:22:18'),
(1837, 11, 'KASUKU A5 200PGS RULED', '6161101536653', 'C128', NULL, 53.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 14:24:29', '2024-06-20 14:24:49'),
(1838, 1, 'PLANET AQUA 1LR', '6161117770324', 'C128', NULL, 26.00, 50.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 14:26:18', '2024-06-20 14:26:35'),
(1839, 1, 'PLANET AQUA 500ML', '6161117770225', 'C128', NULL, 14.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 14:27:15', '2024-06-20 14:27:32'),
(1840, 11, 'KASUKU A5 48PGS RULED', '6161101536530', 'C128', NULL, 15.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 14:38:00', '2024-06-20 14:39:20'),
(1841, 11, 'KASUKU A5 32PGS RULED', '6161101536523', 'C128', NULL, 15.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 14:41:35', '2024-06-20 14:41:53'),
(1842, 11, 'SUPERIOR A5 48PGS PLAIN', '6161102781922', 'C128', NULL, 10.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 14:48:31', '2024-06-20 14:48:59'),
(1843, 11, 'SUPERIOR A5 48PGS MATHS', '6161102783544', 'C128', NULL, 20.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 14:49:54', '2024-06-20 14:50:23'),
(1844, 11, 'INSPIRE A5 HALF INCH 48PGS', '644197319622', 'C128', NULL, 25.00, 30.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 14:53:14', '2024-06-20 14:53:30'),
(1845, 11, 'INSPIRE A5 HALF INCH 96PGS', '644197320239', 'C128', NULL, 30.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 14:54:02', '2024-06-20 14:54:17'),
(1846, 11, 'KASUKU A4 48PGS RULED', '6161101536691', 'C128', NULL, 31.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 14:58:20', '2024-06-20 14:58:41'),
(1847, 11, 'KASUKU A4 64PGS MATHS', '6161101536721', 'C128', NULL, 38.00, 45.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 15:02:28', '2024-06-20 15:02:47'),
(1848, 11, 'KASUKU A4PGS MATHS', '6161101536783', 'C128', NULL, 65.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 15:07:23', '2024-06-20 15:07:51'),
(1849, 11, 'KASUKU A4 96PGS MATHS', '6161101536769', 'C128', NULL, 55.00, 65.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 15:12:10', '2024-06-20 15:12:35'),
(1850, 11, 'KASUKU A4 200PGS MATHS', '6161101536806', 'C128', NULL, 85.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 15:16:42', '2024-06-20 15:17:18'),
(1851, 11, 'POLAR A4 120PGS MATHS', '6161105420149', 'C128', NULL, 85.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 15:18:06', '2024-06-20 15:18:30'),
(1852, 11, 'POLAR A4 120PGS RULED', '6161105420132', 'C128', NULL, 85.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 15:19:14', '2024-06-20 15:19:32'),
(1853, 2, 'NUVITA WAFERS STRABERRY', '6161103943152', 'C128', NULL, 3.00, 5.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 15:33:10', '2024-06-20 15:33:22'),
(1854, 9, 'ARROW MOSQUITO COIL', 'IT01854', 'C128', NULL, 10.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 15:41:55', '2024-06-20 15:41:55'),
(1855, 1, 'EGGS', 'IT01855', 'C128', NULL, 13.00, 15.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 15:44:45', '2024-06-20 15:44:45'),
(1856, 11, 'OFFICE POINT', '6162004210626', 'C128', NULL, 16.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 15:55:20', '2024-06-20 15:55:39'),
(1857, 6, 'REXONA SHOWER CLEAN', '4800888182128', 'C128', NULL, 140.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 19:11:13', '2024-06-20 19:11:41'),
(1858, 6, 'REXONA QUANTUM DRY', 'IT01858', 'C128', NULL, 140.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 19:13:07', '2024-06-20 19:13:07'),
(1859, 6, 'REXONA POWDER DRY', '4800888182180', 'C128', NULL, 140.00, 200.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 19:13:55', '2024-06-20 19:17:29'),
(1860, 6, 'SUBARU GOLG', 'IT01860', 'C128', NULL, 45.00, 70.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 19:35:43', '2024-06-20 19:35:43'),
(1861, 6, 'MATTE SLEEK LIP STICK MAROON', 'IT01861', 'C128', NULL, 90.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 19:59:39', '2024-06-20 20:00:11'),
(1862, 6, 'MATTE SLEEK LIP STICK RED', 'IT01862', 'C128', NULL, 90.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 20:01:06', '2024-06-20 20:01:19'),
(1863, 6, 'MATTE SLEEK LIP STICK PURPLE', 'IT01863', 'C128', NULL, 90.00, 120.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 20:03:57', '2024-06-20 20:04:15'),
(1864, 6, 'MISS LOOK LIP GLOSS PINK 10ML', 'IT01864', 'C128', NULL, 70.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 20:07:22', '2024-06-20 20:07:33'),
(1865, 6, 'KOTEX TAMPON NORMAL', '5029053534800', 'C128', NULL, 310.00, 360.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 20:16:44', '2024-06-20 21:43:16'),
(1866, 4, 'SOFTCARE DIAPERS XL 36PCS', '6166000121825', 'C128', NULL, 670.00, 720.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 21:26:56', '2024-06-20 21:27:30'),
(1867, 4, 'SOFTCARE DIAPER MEDIUM 42PCS', '6166000121849', 'C128', NULL, 608.00, 690.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 21:28:39', '2024-06-20 21:29:13'),
(1868, 4, 'MOLFIX NO3 42PCS', '6224008817567', 'C128', NULL, 560.00, 650.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 21:40:50', '2024-06-20 21:41:15'),
(1869, 7, 'TEEPEE SCRUBBING BRUSH', '6161102262162', 'C128', NULL, 70.00, 100.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 21:49:27', '2024-06-20 21:49:50'),
(1870, 2, 'OMIGO BISCUIT 5G', 'IT01870', 'C128', NULL, 2.00, 5.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 22:08:49', '2024-06-20 22:08:49'),
(1871, 2, 'FRESH PEPPERMINT CHEWING GUM', '6161112464631', 'C128', NULL, 5.00, 10.00, NULL, '5', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 22:20:49', '2024-06-20 22:21:19'),
(1872, 2, 'TING TING STRAWBERRY FLAVOUR', '6161112463917', 'C128', NULL, 4.00, 5.00, NULL, '5', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 22:25:21', '2024-06-20 22:25:42'),
(1873, 2, 'TING TING PASSION FLAVOUR', '6161112463924', 'C128', NULL, 4.00, 5.00, NULL, '5', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 22:26:55', '2024-06-20 22:27:16'),
(1874, 2, 'FRESH PEPPERMINT 10PELLETS', '6161100849471', 'C128', NULL, 12.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 22:28:27', '2024-06-20 22:29:00'),
(1875, 2, 'FRESH COOL FRUITY 10PELLETS', '6161100849495', 'C128', NULL, 12.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 22:30:10', '2024-06-20 22:30:58'),
(1876, 2, 'FRESH WATERMELON 10PELLETS', '6161112464907', 'C128', NULL, 12.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 22:32:17', '2024-06-20 22:33:14'),
(1877, 2, 'FRESH MENTHOL 10 PELLETS', '6161100849464', 'C128', NULL, 12.00, 20.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 22:34:05', '2024-06-20 22:34:25'),
(1878, 2, 'BIG BOSS BLUE', '6161103035574', 'C128', NULL, 3.00, 5.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-20 22:38:26', '2024-06-20 22:38:47'),
(1879, 2, 'CHILLI BALLS', 'IT01879', 'C128', NULL, 1.00, 2.50, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 01:39:10', '2024-06-21 14:25:43'),
(1880, 4, 'BELLA WHITE 8ROLLS', '6164000242564', 'C128', NULL, 258.00, 320.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 01:54:32', '2024-06-21 01:54:57'),
(1881, 7, 'HANAN TRAVEL TISSUE', 'IT01881', 'C128', NULL, 35.00, 45.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 01:57:32', '2024-06-21 01:57:32'),
(1882, 1, 'KENSALT 2KG', 'IT01882', 'C128', NULL, 66.00, 90.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 01:59:03', '2024-06-21 01:59:03'),
(1883, 2, 'TOOGOODY TOFFEE', '6161103032412', 'C128', -1, 4.00, 10.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 13:19:14', '2024-06-21 13:23:50'),
(1884, 2, 'CHOCOLATEE', '6164000658631', 'C128', -1, 4.00, 10.00, NULL, 'P', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 13:22:04', '2024-06-21 13:23:50'),
(1885, 2, 'MULTSTARS 18G', '6223005591241', 'C128', -1, 12.00, 25.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 13:33:25', '2024-06-21 13:34:45'),
(1886, 1, 'SUGAR   1KG', 'IT01886', 'C128', NULL, 115.00, 160.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 14:04:33', '2024-06-21 14:04:33'),
(1887, 1, 'SUGAR  1/2KG', 'IT01887', 'C128', NULL, 58.00, 80.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 14:06:34', '2024-06-21 14:06:34'),
(1888, 1, 'SUGAR 1/4KG', 'IT01888', 'C128', NULL, 29.00, 40.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 14:07:21', '2024-06-21 14:07:21'),
(1889, 1, 'SALAD 1L', 'IT01889', 'C128', -1, 200.00, 230.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 15:29:13', '2024-06-21 16:26:26'),
(1890, 2, 'PINPOP', 'IT01890', 'C128', -1, 10.00, 15.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 15:40:36', '2024-06-21 15:41:31'),
(1891, 1, 'CHOCO HEART CAKE', 'IT01891', 'C128', NULL, 50.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 15:59:43', '2024-06-21 15:59:43'),
(1892, 1, 'CHOKO BROWN HEART CAKE', 'IT01892', 'C128', NULL, 50.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 16:09:45', '2024-06-21 16:09:45'),
(1893, 2, 'COOCKIES', 'IT01893', 'C128', NULL, 50.00, 60.00, NULL, 'PIECES', 5, NULL, NULL, NULL, NULL, NULL, '2024-06-21 16:10:27', '2024-06-21 16:10:27'),
(1894, 4, 'MOLPED PANTY LINER', '8690536834976', 'C128', NULL, 110.00, 150.00, NULL, 'PIECES', 2, NULL, NULL, NULL, NULL, NULL, '2024-06-21 17:52:12', '2024-06-21 17:52:49');

-- --------------------------------------------------------

--
-- Table structure for table `product_branches`
--

CREATE TABLE `product_branches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_branches`
--

INSERT INTO `product_branches` (`id`, `product_id`, `branch_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1707, 1, 0, '2024-06-18 03:00:44', '2024-06-18 03:00:44'),
(2, 1708, 1, 0, '2024-06-18 03:11:00', '2024-06-18 03:11:00'),
(3, 1709, 1, 0, '2024-06-17 19:48:10', '2024-06-17 19:48:10'),
(4, 1710, 1, 0, '2024-06-17 19:53:23', '2024-06-17 19:53:23'),
(5, 1711, 1, 0, '2024-06-17 20:07:39', '2024-06-17 20:07:39'),
(6, 1712, 1, 0, '2024-06-17 20:11:40', '2024-06-17 20:11:40'),
(7, 1713, 1, 0, '2024-06-17 20:28:34', '2024-06-17 20:28:34'),
(8, 1714, 1, 0, '2024-06-17 20:31:36', '2024-06-17 20:31:36'),
(9, 1715, 1, 0, '2024-06-17 20:40:43', '2024-06-17 20:40:43'),
(10, 1716, 1, 0, '2024-06-17 20:42:04', '2024-06-17 20:42:04'),
(11, 1717, 1, 0, '2024-06-17 20:52:26', '2024-06-17 20:52:26'),
(12, 1718, 1, 0, '2024-06-17 20:54:03', '2024-06-17 20:54:03'),
(13, 1719, 1, 0, '2024-06-17 20:58:30', '2024-06-17 20:58:30'),
(14, 1720, 1, 0, '2024-06-17 21:02:36', '2024-06-17 21:02:36'),
(15, 1721, 1, 0, '2024-06-17 21:08:51', '2024-06-17 21:08:51'),
(16, 1722, 1, 0, '2024-06-17 21:38:37', '2024-06-17 21:38:37'),
(17, 1723, 1, 0, '2024-06-17 21:48:54', '2024-06-17 21:48:54'),
(18, 1724, 1, 0, '2024-06-17 21:51:01', '2024-06-17 21:51:01'),
(19, 1725, 1, 0, '2024-06-17 21:53:38', '2024-06-17 21:53:38'),
(20, 1726, 1, 0, '2024-06-17 21:59:49', '2024-06-17 21:59:49'),
(21, 1727, 1, 0, '2024-06-17 22:08:46', '2024-06-17 22:08:46'),
(22, 1728, 1, 0, '2024-06-17 22:12:34', '2024-06-17 22:12:34'),
(23, 1729, 1, 0, '2024-06-17 22:13:07', '2024-06-17 22:13:07'),
(24, 1730, 1, 0, '2024-06-17 22:19:37', '2024-06-17 22:19:37'),
(25, 1731, 1, 0, '2024-06-17 22:26:28', '2024-06-17 22:26:28'),
(26, 1732, 1, 0, '2024-06-17 23:25:50', '2024-06-17 23:25:50'),
(27, 1733, 1, 0, '2024-06-17 23:32:53', '2024-06-17 23:32:53'),
(28, 1734, 1, 0, '2024-06-17 23:33:55', '2024-06-17 23:33:55'),
(29, 1735, 1, 0, '2024-06-17 23:34:35', '2024-06-17 23:34:35'),
(30, 1736, 1, 0, '2024-06-17 23:47:55', '2024-06-17 23:47:55'),
(31, 1737, 1, 0, '2024-06-17 23:48:30', '2024-06-17 23:48:30'),
(32, 1738, 1, 0, '2024-06-17 23:49:25', '2024-06-17 23:49:25'),
(33, 1739, 1, 0, '2024-06-17 23:50:22', '2024-06-17 23:50:22'),
(34, 1740, 1, 0, '2024-06-17 23:54:39', '2024-06-17 23:54:39'),
(35, 1741, 1, 0, '2024-06-18 00:00:57', '2024-06-18 00:00:57'),
(36, 1742, 1, 0, '2024-06-18 00:01:52', '2024-06-18 00:01:52'),
(37, 1743, 1, 0, '2024-06-18 00:02:32', '2024-06-18 00:02:32'),
(38, 1744, 1, 0, '2024-06-18 00:03:11', '2024-06-18 00:03:11'),
(39, 1745, 1, 0, '2024-06-18 00:03:52', '2024-06-18 00:03:52'),
(40, 1746, 1, 0, '2024-06-18 00:05:14', '2024-06-18 00:05:14'),
(41, 1747, 1, 0, '2024-06-18 00:24:38', '2024-06-18 00:24:38'),
(42, 1748, 1, 0, '2024-06-18 00:25:22', '2024-06-18 00:25:22'),
(43, 1749, 1, 0, '2024-06-18 00:47:47', '2024-06-18 00:47:47'),
(44, 1750, 1, 0, '2024-06-18 00:53:29', '2024-06-18 00:53:29'),
(45, 1751, 1, 0, '2024-06-18 01:07:19', '2024-06-18 01:07:19'),
(46, 1752, 1, 0, '2024-06-18 01:34:05', '2024-06-18 01:34:05'),
(47, 1753, 1, 0, '2024-06-18 01:52:24', '2024-06-18 01:52:24'),
(48, 1754, 1, 0, '2024-06-18 02:20:34', '2024-06-21 01:13:21'),
(49, 1755, 1, 0, '2024-06-18 03:18:53', '2024-06-18 03:18:53'),
(50, 1756, 1, 0, '2024-06-18 03:23:52', '2024-06-18 03:23:52'),
(51, 1757, 1, 0, '2024-06-18 04:35:31', '2024-06-18 04:35:31'),
(52, 1758, 1, 0, '2024-06-18 04:45:49', '2024-06-18 04:45:49'),
(53, 1759, 1, 0, '2024-06-18 04:51:05', '2024-06-18 04:51:05'),
(54, 1760, 1, 0, '2024-06-18 04:58:17', '2024-06-18 04:58:17'),
(55, 1761, 1, 0, '2024-06-18 04:03:12', '2024-06-18 04:03:12'),
(56, 1762, 1, 0, '2024-06-18 04:11:37', '2024-06-18 04:11:37'),
(57, 1763, 1, 0, '2024-06-18 04:20:44', '2024-06-18 04:20:44'),
(58, 1764, 1, 0, '2024-06-18 04:23:57', '2024-06-18 04:23:57'),
(59, 1765, 1, 0, '2024-06-18 04:25:26', '2024-06-18 04:25:26'),
(60, 1766, 1, 0, '2024-06-18 04:26:27', '2024-06-18 04:26:27'),
(61, 1767, 1, 0, '2024-06-18 04:27:39', '2024-06-18 04:27:39'),
(62, 1768, 1, 0, '2024-06-18 04:38:57', '2024-06-18 04:38:57'),
(63, 1769, 1, 0, '2024-06-18 04:41:09', '2024-06-18 04:41:09'),
(64, 1770, 1, 0, '2024-06-18 04:58:35', '2024-06-18 04:58:35'),
(65, 1771, 1, 0, '2024-06-18 05:21:11', '2024-06-18 05:21:11'),
(66, 1772, 1, 0, '2024-06-18 05:23:06', '2024-06-18 05:23:06'),
(67, 1773, 1, 0, '2024-06-18 05:24:30', '2024-06-18 05:24:30'),
(68, 1774, 1, 0, '2024-06-18 05:26:01', '2024-06-18 05:26:01'),
(69, 1775, 1, 0, '2024-06-18 05:27:15', '2024-06-18 05:27:15'),
(70, 1776, 1, 0, '2024-06-18 05:32:13', '2024-06-18 05:32:13'),
(71, 1777, 1, 0, '2024-06-18 05:34:03', '2024-06-18 05:34:03'),
(72, 1778, 1, 0, '2024-06-18 05:40:10', '2024-06-18 05:40:10'),
(73, 1779, 1, 0, '2024-06-18 05:41:32', '2024-06-18 05:41:32'),
(74, 1780, 1, 0, '2024-06-18 05:43:12', '2024-06-18 05:43:12'),
(75, 1781, 1, 0, '2024-06-18 05:54:30', '2024-06-18 05:54:30'),
(76, 1782, 1, 0, '2024-06-18 05:56:03', '2024-06-18 05:56:03'),
(77, 1783, 1, 0, '2024-06-18 05:57:24', '2024-06-18 05:57:24'),
(78, 1784, 1, 0, '2024-06-18 06:01:22', '2024-06-18 06:01:22'),
(79, 1785, 1, 0, '2024-06-18 06:04:47', '2024-06-18 06:04:47'),
(80, 1786, 1, 0, '2024-06-18 06:06:36', '2024-06-18 06:06:36'),
(81, 1787, 1, 0, '2024-06-18 06:15:39', '2024-06-18 06:15:39'),
(82, 1788, 1, 0, '2024-06-18 06:18:15', '2024-06-18 06:18:15'),
(83, 1789, 1, 0, '2024-06-18 06:54:48', '2024-06-18 06:54:48'),
(84, 1790, 1, 0, '2024-06-18 07:20:29', '2024-06-18 07:20:29'),
(85, 1791, 1, 0, '2024-06-18 07:38:25', '2024-06-18 07:38:25'),
(86, 1792, 1, 0, '2024-06-18 08:06:04', '2024-06-18 08:06:04'),
(87, 1793, 1, 0, '2024-06-18 08:10:25', '2024-06-18 08:10:25'),
(88, 1794, 1, 0, '2024-06-18 08:21:30', '2024-06-18 08:21:30'),
(89, 1795, 1, 0, '2024-06-18 08:24:44', '2024-06-18 08:24:44'),
(90, 1796, 1, 0, '2024-06-18 08:54:30', '2024-06-18 08:54:30'),
(91, 1797, 1, 0, '2024-06-18 09:07:19', '2024-06-18 09:07:19'),
(92, 1798, 1, 0, '2024-06-18 09:15:16', '2024-06-18 09:15:16'),
(93, 1799, 1, 0, '2024-06-18 09:35:15', '2024-06-18 09:35:15'),
(94, 1800, 1, 0, '2024-06-18 09:40:48', '2024-06-18 09:40:48'),
(95, 1801, 1, 0, '2024-06-18 09:40:49', '2024-06-18 09:40:49'),
(96, 1802, 1, 0, '2024-06-18 09:50:57', '2024-06-18 09:50:57'),
(97, 1803, 1, 0, '2024-06-18 10:13:29', '2024-06-18 10:13:29'),
(98, 1804, 1, 0, '2024-06-18 10:29:29', '2024-06-18 10:29:29'),
(99, 1805, 1, 0, '2024-06-18 10:46:29', '2024-06-18 10:46:29'),
(100, 1806, 1, 0, '2024-06-18 11:33:23', '2024-06-18 11:33:23'),
(101, 1807, 1, 0, '2024-06-18 11:41:49', '2024-06-18 11:41:49'),
(102, 1808, 1, 0, '2024-06-18 12:09:49', '2024-06-18 12:09:49'),
(103, 1809, 1, 0, '2024-06-18 12:13:08', '2024-06-18 12:13:08'),
(104, 1810, 1, 0, '2024-06-18 12:32:37', '2024-06-18 12:32:37'),
(105, 1811, 1, 0, '2024-06-18 12:46:47', '2024-06-18 12:46:47'),
(106, 1812, 1, 0, '2024-06-18 13:08:42', '2024-06-21 17:08:39'),
(107, 1813, 1, 0, '2024-06-18 13:34:55', '2024-06-18 13:34:55'),
(108, 1814, 1, 0, '2024-06-18 13:38:21', '2024-06-18 13:38:21'),
(109, 1815, 1, 0, '2024-06-20 09:25:23', '2024-06-20 09:25:23'),
(110, 1816, 1, 0, '2024-06-20 09:41:32', '2024-06-21 02:04:27'),
(111, 1817, 1, 0, '2024-06-20 09:55:16', '2024-06-21 16:17:22'),
(112, 1818, 1, 0, '2024-06-20 10:05:45', '2024-06-20 10:05:45'),
(113, 1819, 1, 0, '2024-06-20 10:10:29', '2024-06-20 10:10:29'),
(114, 1820, 1, 0, '2024-06-20 10:11:39', '2024-06-20 10:11:39'),
(115, 1821, 1, 0, '2024-06-20 10:18:17', '2024-06-21 15:04:24'),
(116, 1822, 1, 0, '2024-06-20 10:29:17', '2024-06-20 10:29:17'),
(117, 1823, 1, 0, '2024-06-20 11:47:21', '2024-06-20 11:47:21'),
(118, 1824, 1, 0, '2024-06-20 11:51:37', '2024-06-20 11:51:37'),
(119, 1825, 1, 0, '2024-06-20 11:57:47', '2024-06-20 11:57:47'),
(120, 1826, 1, 0, '2024-06-20 11:59:12', '2024-06-20 11:59:12'),
(121, 1827, 1, 0, '2024-06-20 12:03:58', '2024-06-20 12:03:58'),
(122, 1828, 1, 0, '2024-06-20 12:09:08', '2024-06-20 12:09:08'),
(123, 1829, 1, 0, '2024-06-20 12:56:58', '2024-06-20 12:56:58'),
(124, 1830, 1, 0, '2024-06-20 12:58:49', '2024-06-21 13:34:45'),
(125, 1831, 1, 0, '2024-06-20 13:00:36', '2024-06-20 13:00:36'),
(126, 1832, 1, 0, '2024-06-20 13:02:22', '2024-06-20 13:02:22'),
(127, 1833, 1, 0, '2024-06-20 13:12:30', '2024-06-20 13:12:30'),
(128, 1834, 1, 0, '2024-06-20 13:27:35', '2024-06-20 13:27:35'),
(129, 1835, 1, 0, '2024-06-20 14:09:28', '2024-06-20 14:09:28'),
(130, 1836, 1, 0, '2024-06-20 14:21:08', '2024-06-20 14:21:08'),
(131, 1837, 1, 0, '2024-06-20 14:24:29', '2024-06-20 14:24:29'),
(132, 1838, 1, 0, '2024-06-20 14:26:18', '2024-06-20 14:26:18'),
(133, 1839, 1, 0, '2024-06-20 14:27:15', '2024-06-20 14:27:15'),
(134, 1840, 1, 0, '2024-06-20 14:38:00', '2024-06-20 14:38:00'),
(135, 1841, 1, 0, '2024-06-20 14:41:35', '2024-06-20 14:41:35'),
(136, 1842, 1, 0, '2024-06-20 14:48:31', '2024-06-20 14:48:31'),
(137, 1843, 1, 0, '2024-06-20 14:49:54', '2024-06-20 14:49:54'),
(138, 1844, 1, 0, '2024-06-20 14:53:14', '2024-06-20 14:53:14'),
(139, 1845, 1, 0, '2024-06-20 14:54:02', '2024-06-20 14:54:02'),
(140, 1846, 1, 0, '2024-06-20 14:58:20', '2024-06-20 14:58:20'),
(141, 1847, 1, 0, '2024-06-20 15:02:28', '2024-06-20 15:02:28'),
(142, 1848, 1, 0, '2024-06-20 15:07:23', '2024-06-20 15:07:23'),
(143, 1849, 1, 0, '2024-06-20 15:12:10', '2024-06-20 15:12:10'),
(144, 1850, 1, 0, '2024-06-20 15:16:42', '2024-06-20 15:16:42'),
(145, 1851, 1, 0, '2024-06-20 15:18:06', '2024-06-20 15:18:06'),
(146, 1852, 1, 0, '2024-06-20 15:19:14', '2024-06-20 15:19:14'),
(147, 1853, 1, 0, '2024-06-20 15:33:10', '2024-06-20 15:33:10'),
(148, 1854, 1, 0, '2024-06-20 15:41:55', '2024-06-20 15:41:55'),
(149, 1855, 1, 0, '2024-06-20 15:44:45', '2024-06-20 15:44:45'),
(150, 1856, 1, 0, '2024-06-20 15:55:20', '2024-06-20 15:55:20'),
(151, 1857, 1, 0, '2024-06-20 19:11:14', '2024-06-20 19:11:14'),
(152, 1858, 1, 0, '2024-06-20 19:13:07', '2024-06-20 19:13:07'),
(153, 1859, 1, 0, '2024-06-20 19:13:55', '2024-06-20 19:13:55'),
(154, 1860, 1, 0, '2024-06-20 19:35:43', '2024-06-20 19:35:43'),
(155, 1861, 1, 0, '2024-06-20 19:59:39', '2024-06-20 19:59:39'),
(156, 1862, 1, 0, '2024-06-20 20:01:06', '2024-06-20 20:01:06'),
(157, 1863, 1, 0, '2024-06-20 20:03:57', '2024-06-20 20:03:57'),
(158, 1864, 1, 0, '2024-06-20 20:07:22', '2024-06-20 20:07:22'),
(159, 1865, 1, 0, '2024-06-20 20:16:44', '2024-06-20 20:16:44'),
(160, 1866, 1, 0, '2024-06-20 21:26:56', '2024-06-20 21:26:56'),
(161, 1867, 1, 0, '2024-06-20 21:28:39', '2024-06-20 21:28:39'),
(162, 1868, 1, 0, '2024-06-20 21:40:50', '2024-06-20 21:40:50'),
(163, 1869, 1, 0, '2024-06-20 21:49:27', '2024-06-20 21:49:27'),
(164, 1870, 1, 0, '2024-06-20 22:08:49', '2024-06-20 22:08:49'),
(165, 1871, 1, 0, '2024-06-20 22:20:49', '2024-06-20 22:20:49'),
(166, 1872, 1, 0, '2024-06-20 22:25:21', '2024-06-20 22:25:21'),
(167, 1873, 1, 0, '2024-06-20 22:26:55', '2024-06-20 22:26:55'),
(168, 1874, 1, 0, '2024-06-20 22:28:27', '2024-06-20 22:28:27'),
(169, 1875, 1, 0, '2024-06-20 22:30:10', '2024-06-20 22:30:10'),
(170, 1876, 1, 0, '2024-06-20 22:32:17', '2024-06-20 22:32:17'),
(171, 1877, 1, 0, '2024-06-20 22:34:05', '2024-06-20 22:34:05'),
(172, 1878, 1, 0, '2024-06-20 22:38:26', '2024-06-20 22:38:26'),
(173, 1879, 1, 0, '2024-06-21 01:39:10', '2024-06-21 01:39:10'),
(174, 1880, 1, 0, '2024-06-21 01:54:32', '2024-06-21 01:54:32'),
(175, 1881, 1, 0, '2024-06-21 01:57:32', '2024-06-21 01:57:32'),
(176, 1882, 1, 0, '2024-06-21 01:59:03', '2024-06-21 01:59:03'),
(177, 1883, 1, 0, '2024-06-21 13:19:14', '2024-06-21 13:23:50'),
(178, 1884, 1, 0, '2024-06-21 13:22:04', '2024-06-21 13:23:50'),
(179, 1885, 1, 0, '2024-06-21 13:33:25', '2024-06-21 13:34:45'),
(180, 1886, 1, 0, '2024-06-21 14:04:33', '2024-06-21 14:04:33'),
(181, 1887, 1, 0, '2024-06-21 14:06:34', '2024-06-21 14:06:34'),
(182, 1888, 1, 0, '2024-06-21 14:07:21', '2024-06-21 14:07:21'),
(183, 1889, 1, 0, '2024-06-21 15:29:13', '2024-06-21 16:26:26'),
(184, 1890, 1, 0, '2024-06-21 15:40:36', '2024-06-21 15:56:48'),
(185, 1891, 1, 0, '2024-06-21 15:59:43', '2024-06-21 15:59:43'),
(186, 1892, 1, 0, '2024-06-21 16:09:45', '2024-06-21 16:09:45'),
(187, 1893, 1, 0, '2024-06-21 16:10:27', '2024-06-21 16:10:27'),
(188, 1894, 1, 0, '2024-06-21 17:52:12', '2024-06-21 17:52:12');

-- --------------------------------------------------------

--
-- Table structure for table `product_transfers`
--

CREATE TABLE `product_transfers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `transfer_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `reference` varchar(255) NOT NULL,
  `supplier_id` bigint(20) UNSIGNED DEFAULT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `tax_percentage` int(11) NOT NULL DEFAULT 0,
  `tax_amount` int(11) NOT NULL DEFAULT 0,
  `discount_percentage` int(11) NOT NULL DEFAULT 0,
  `discount_amount` int(11) NOT NULL DEFAULT 0,
  `shipping_amount` int(11) NOT NULL DEFAULT 0,
  `total_amount` int(11) NOT NULL,
  `paid_amount` int(11) NOT NULL,
  `due_amount` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `payment_status` varchar(255) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `sale_details` varchar(100) DEFAULT NULL,
  `is_openingstock` tinyint(1) NOT NULL DEFAULT 0,
  `note` text DEFAULT NULL,
  `location_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_bulk_payments`
--

CREATE TABLE `purchase_bulk_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference` varchar(255) NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `date` date DEFAULT NULL,
  `payment_method` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_details`
--

CREATE TABLE `purchase_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `itemcode` varchar(50) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `reference` varchar(191) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `unit_price` int(11) NOT NULL,
  `sale_details` varchar(191) DEFAULT NULL,
  `sub_total` int(11) NOT NULL,
  `sale_type` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `product_discount_amount` int(11) DEFAULT 0,
  `product_discount_type` varchar(255) NOT NULL DEFAULT 'fixed',
  `product_tax_amount` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_payments`
--

CREATE TABLE `purchase_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_id` bigint(20) UNSIGNED DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `date` date NOT NULL,
  `reference` varchar(255) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `clientcode` varchar(50) DEFAULT NULL,
  `cheque` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_returns`
--

CREATE TABLE `purchase_returns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `reference` varchar(255) NOT NULL,
  `supplier_id` bigint(20) UNSIGNED DEFAULT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `tax_percentage` int(11) NOT NULL DEFAULT 0,
  `tax_amount` int(11) NOT NULL DEFAULT 0,
  `discount_percentage` int(11) NOT NULL DEFAULT 0,
  `discount_amount` int(11) NOT NULL DEFAULT 0,
  `shipping_amount` int(11) NOT NULL DEFAULT 0,
  `total_amount` int(11) NOT NULL,
  `paid_amount` int(11) NOT NULL,
  `due_amount` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return_details`
--

CREATE TABLE `purchase_return_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_return_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `unit_price` int(11) NOT NULL,
  `sub_total` int(11) NOT NULL,
  `product_discount_amount` int(11) NOT NULL,
  `product_discount_type` varchar(255) NOT NULL DEFAULT 'fixed',
  `product_tax_amount` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return_payments`
--

CREATE TABLE `purchase_return_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_return_id` bigint(20) UNSIGNED NOT NULL,
  `amount` int(11) NOT NULL,
  `date` date NOT NULL,
  `reference` varchar(255) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `reference` varchar(255) NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_name` varchar(255) NOT NULL,
  `tax_percentage` int(11) NOT NULL DEFAULT 0,
  `tax_amount` int(11) NOT NULL DEFAULT 0,
  `discount_percentage` int(11) NOT NULL DEFAULT 0,
  `discount_amount` int(11) NOT NULL DEFAULT 0,
  `shipping_amount` int(11) NOT NULL DEFAULT 0,
  `total_amount` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotation_details`
--

CREATE TABLE `quotation_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quotation_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `unit_price` int(11) NOT NULL,
  `sub_total` int(11) NOT NULL,
  `product_discount_amount` int(11) NOT NULL,
  `product_discount_type` varchar(255) NOT NULL DEFAULT 'fixed',
  `product_tax_amount` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'ADMIN', 'web', '2023-02-04 17:44:33', '2024-04-25 08:34:59'),
(2, 'Super Admin', 'web', '2023-02-04 17:44:34', '2023-02-04 17:44:34'),
(3, 'CASHIER', 'web', '2024-04-25 08:34:34', '2024-04-25 08:34:34');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 3),
(2, 1),
(2, 3),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(8, 3),
(9, 1),
(9, 3),
(10, 1),
(10, 3),
(11, 1),
(11, 3),
(12, 1),
(13, 1),
(13, 3),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(27, 3),
(28, 1),
(28, 3),
(29, 1),
(30, 1),
(31, 1),
(31, 3),
(32, 1),
(32, 3),
(33, 1),
(33, 3),
(34, 1),
(34, 3),
(35, 1),
(36, 1),
(37, 1),
(37, 3),
(38, 1),
(38, 3),
(39, 1),
(39, 3),
(40, 1),
(42, 1),
(42, 3),
(43, 1),
(43, 3),
(45, 1),
(46, 1),
(47, 1),
(47, 3),
(48, 1),
(48, 3),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(55, 3),
(56, 1),
(56, 3),
(57, 1),
(57, 3),
(58, 1),
(59, 1),
(60, 1),
(60, 3),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(72, 1);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `reference` varchar(255) NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `clientcode` varchar(191) DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `tax_percentage` int(11) NOT NULL DEFAULT 0,
  `tax_amount` int(11) NOT NULL DEFAULT 0,
  `discount_percentage` int(11) NOT NULL DEFAULT 0,
  `discount_amount` int(11) NOT NULL DEFAULT 0,
  `shipping_amount` int(11) NOT NULL DEFAULT 0,
  `total_amount` decimal(8,2) NOT NULL,
  `paid_amount` decimal(8,2) DEFAULT NULL,
  `due_amount` decimal(8,2) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `payment_status` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `order_no` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `change_amount` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `date`, `reference`, `customer_id`, `clientcode`, `branch_id`, `customer_name`, `tax_percentage`, `tax_amount`, `discount_percentage`, `discount_amount`, `shipping_amount`, `total_amount`, `paid_amount`, `due_amount`, `status`, `payment_status`, `payment_method`, `note`, `order_no`, `deleted_at`, `created_at`, `updated_at`, `change_amount`, `user_id`) VALUES
(1, '2024-06-21', 'SL-00001', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 65.00, 65.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 01:28:10', '2024-06-21 01:28:10', 0, 9),
(2, '2024-06-21', 'SL-00002', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 110.00, 110.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 01:33:09', '2024-06-21 01:33:09', 0, 9),
(3, '2024-06-21', 'SL-00003', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 245.00, 245.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 01:35:15', '2024-06-21 01:35:15', 0, 9),
(4, '2024-06-21', 'SL-00004', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 175.00, 175.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 01:43:53', '2024-06-21 01:43:53', 0, 9),
(5, '2024-06-21', 'SL-00005', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 150.00, 150.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 02:04:27', '2024-06-21 02:04:27', 0, 9),
(6, '2024-06-21', 'SL-00006', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 105.00, 105.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 02:23:08', '2024-06-21 02:23:08', 0, 10),
(7, '2024-06-21', 'SL-00007', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 290.00, 290.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 02:38:39', '2024-06-21 02:38:39', 0, 10),
(8, '2024-06-21', 'SL-00008', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 90.00, 90.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 13:09:54', '2024-06-21 13:28:57', 0, 10),
(9, '2024-06-21', 'SL-00009', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 20.00, 20.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 13:23:50', '2024-06-21 13:23:50', 0, 8),
(10, '2024-06-21', 'SL-00010', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 75.00, 75.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 13:34:45', '2024-06-21 13:34:45', 0, 10),
(11, '2024-06-21', 'SL-00011', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 200.00, 200.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 13:55:37', '2024-06-21 13:55:37', 0, 10),
(12, '2024-06-21', 'SL-00012', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 120.00, 120.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 14:39:06', '2024-06-21 14:39:06', 0, 9),
(13, '2024-06-21', 'SL-00013', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 20.00, 20.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 14:41:04', '2024-06-21 14:41:04', 0, 9),
(14, '2024-06-21', 'SL-00014', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 100.00, 100.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 14:42:13', '2024-06-21 14:42:13', 0, 9),
(15, '2024-06-21', 'SL-00015', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 130.00, 130.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 14:44:28', '2024-06-21 14:44:28', 370, 9),
(16, '2024-06-21', 'SL-00016', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 200.00, 200.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 14:53:52', '2024-06-21 14:53:52', 800, 9),
(17, '2024-06-21', 'SL-00017', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 80.00, 80.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 15:01:22', '2024-06-21 15:01:22', 0, 9),
(18, '2024-06-21', 'SL-00018', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 270.00, 270.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 15:04:24', '2024-06-21 15:04:24', 0, 9),
(19, '2024-06-21', 'SL-00019', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 110.00, 110.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 15:05:35', '2024-06-21 15:05:35', 40, 9),
(20, '2024-06-21', 'SL-00020', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 60.00, 60.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 15:15:11', '2024-06-21 15:15:11', 40, 9),
(21, '2024-06-21', 'SL-00021', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 60.00, 60.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 15:16:13', '2024-06-21 15:16:13', 0, 9),
(22, '2024-06-21', 'SL-00022', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 50.00, 50.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 15:27:50', '2024-06-21 15:27:50', 0, 9),
(23, '2024-06-21', 'SL-00023', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 50.00, 50.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 15:38:25', '2024-06-21 15:38:25', 0, 9),
(24, '2024-06-21', 'SL-00024', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 155.00, 155.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 15:41:31', '2024-06-21 15:41:31', 45, 9),
(25, '2024-06-21', 'SL-00025', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 65.00, 65.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 15:42:36', '2024-06-21 15:42:36', 0, 9),
(26, '2024-06-21', 'SL-00026', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 65.00, 65.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 15:43:56', '2024-06-21 15:43:56', 0, 9),
(27, '2024-06-21', 'SL-00027', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 49.91, 49.91, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 15:46:19', '2024-06-21 15:46:19', 0, 9),
(28, '2024-06-21', 'SL-00028', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 135.00, 135.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 15:47:50', '2024-06-21 15:47:50', 0, 9),
(29, '2024-06-21', 'SL-00029', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 370.00, 370.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 15:49:52', '2024-06-21 15:49:52', 0, 9),
(30, '2024-06-21', 'SL-00030', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 115.00, 115.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 15:50:54', '2024-06-21 15:50:54', 0, 9),
(31, '2024-06-21', 'SL-00031', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 210.00, 210.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 15:52:06', '2024-06-21 15:52:06', 790, 9),
(32, '2024-06-21', 'SL-00032', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 309.96, 309.96, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 15:56:47', '2024-06-21 15:56:47', 0, 9),
(33, '2024-06-21', 'SL-00033', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 35.00, 35.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 16:03:13', '2024-06-21 16:03:13', 0, 9),
(34, '2024-06-21', 'SL-00034', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 135.00, 135.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 16:07:10', '2024-06-21 16:07:10', 65, 9),
(35, '2024-06-21', 'SL-00035', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 305.00, 305.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 16:11:07', '2024-06-21 16:11:07', 695, 9),
(36, '2024-06-21', 'SL-00036', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 125.00, 125.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 16:13:56', '2024-06-21 16:13:56', 75, 9),
(37, '2024-06-21', 'SL-00037', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 140.00, 140.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 16:15:03', '2024-06-21 16:15:03', 60, 9),
(38, '2024-06-21', 'SL-00038', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 60.00, 60.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 16:15:46', '2024-06-21 16:15:46', 40, 9),
(39, '2024-06-21', 'SL-00039', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 260.00, 260.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 16:17:22', '2024-06-21 16:17:22', 0, 9),
(40, '2024-06-21', 'SL-00040', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 25.00, 25.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 16:19:14', '2024-06-21 16:22:02', 0, 9),
(41, '2024-06-21', 'SL-00041', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 25.00, 25.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 16:20:31', '2024-06-21 16:20:31', 0, 9),
(42, '2024-06-21', 'SL-00042', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 110.00, 110.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 16:24:30', '2024-06-21 16:24:30', 0, 9),
(43, '2024-06-21', 'SL-00043', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 200.10, 200.00, 0.10, 'Completed', 'Partial', 'Mpesa', NULL, NULL, NULL, '2024-06-21 16:26:26', '2024-06-21 16:26:26', 0, 9),
(44, '2024-06-21', 'SL-00044', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 325.00, 325.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 16:30:54', '2024-06-21 16:30:54', 675, 9),
(45, '2024-06-21', 'SL-00045', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 25.00, 25.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 16:47:19', '2024-06-21 16:47:19', 0, 8),
(46, '2024-06-21', 'SL-00046', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 75.00, 75.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 17:04:59', '2024-06-21 17:04:59', 675, 8),
(47, '2024-06-21', 'SL-00047', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 65.00, 65.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 17:07:59', '2024-06-21 17:07:59', 135, 8),
(48, '2024-06-21', 'SL-00048', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 75.00, 75.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 17:08:39', '2024-06-21 17:08:39', 0, 8),
(49, '2024-06-21', 'SL-00049', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 580.00, 580.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 17:15:06', '2024-06-21 17:15:06', 120, 8),
(50, '2024-06-21', 'SL-00050', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 65.00, 65.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 17:16:23', '2024-06-21 17:16:23', 0, 8),
(51, '2024-06-21', 'SL-00051', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 175.00, 175.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 17:17:32', '2024-06-21 17:17:32', 0, 8),
(52, '2024-06-21', 'SL-00052', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 225.00, 225.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 17:19:49', '2024-06-21 17:19:49', 775, 8),
(53, '2024-06-21', 'SL-00053', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 190.00, 140.00, 50.00, 'Completed', 'Partial', 'Mpesa', NULL, NULL, NULL, '2024-06-21 17:20:38', '2024-06-21 17:20:38', 0, 8),
(54, '2024-06-21', 'SL-00054', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 20.00, 20.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 17:23:14', '2024-06-21 17:23:14', 0, 8),
(55, '2024-06-21', 'SL-00055', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 10.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 17:34:05', '2024-06-21 17:34:05', 0, 8),
(56, '2024-06-21', 'SL-00056', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 140.00, 140.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 17:36:05', '2024-06-21 17:36:05', 60, 8),
(62, '2024-06-21', 'SL-00062', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 360.00, 360.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 17:38:09', '2024-06-21 17:38:09', 0, 8),
(64, '2024-06-21', 'SL-00064', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 100.00, 100.00, 0.00, 'Completed', 'Paid', 'Mpesa', NULL, NULL, NULL, '2024-06-21 17:39:33', '2024-06-21 17:39:33', 0, 8),
(69, '2024-06-21', 'SL-00069', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 350.00, 350.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-21 17:44:26', '2024-06-21 17:44:26', 0, 8),
(84, '2024-06-22', 'SL-00071', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 20.00, 20.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-22 07:15:17', '2024-06-22 07:15:17', 0, 1),
(88, '2024-06-22', 'SL-00088', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-22 07:21:14', '2024-06-22 07:21:14', 0, 1),
(89, '2024-06-22', 'SL-00089', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 335.00, 335.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-06-22 07:27:12', '2024-06-22 07:27:12', 0, 1),
(92, '2024-07-11', 'SL-00090', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 155.00, 155.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:16:16', '2024-07-11 05:16:16', 0, 1),
(93, '2024-07-11', 'SL-00093', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 90.00, 90.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:27:06', '2024-07-11 05:27:06', 0, 1),
(94, '2024-07-11', 'SL-00094', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 90.00, 90.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:27:36', '2024-07-11 05:27:36', 0, 1),
(95, '2024-07-11', 'SL-00095', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 50.00, 50.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:28:47', '2024-07-11 05:28:47', 0, 1),
(96, '2024-07-11', 'SL-00096', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 50.00, 50.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:31:54', '2024-07-11 05:31:54', 0, 1),
(97, '2024-07-11', 'SL-00097', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 60.00, 60.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:42:23', '2024-07-11 05:42:23', 0, 1),
(98, '2024-07-11', 'SL-00098', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 60.00, 60.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:42:57', '2024-07-11 05:42:57', 0, 1),
(99, '2024-07-11', 'SL-00099', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:43:34', '2024-07-11 05:43:34', 0, 1),
(100, '2024-07-11', 'SL-00100', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:45:20', '2024-07-11 05:45:20', 0, 1),
(101, '2024-07-11', 'SL-00101', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:51:48', '2024-07-11 05:51:48', 0, 1),
(102, '2024-07-11', 'SL-00102', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 20.00, 20.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:54:03', '2024-07-11 05:54:03', 0, 1),
(103, '2024-07-11', 'SL-00103', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 20.00, 20.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:54:12', '2024-07-11 05:54:12', 0, 1),
(104, '2024-07-11', 'SL-00104', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 155.00, 20.00, 135.00, 'Completed', 'Partial', 'Cash', NULL, NULL, NULL, '2024-07-11 05:55:02', '2024-07-11 05:55:02', 0, 1),
(105, '2024-07-11', 'SL-00105', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 50.00, 50.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:55:28', '2024-07-11 05:55:28', 0, 1),
(106, '2024-07-11', 'SL-00106', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 10.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:56:38', '2024-07-11 05:56:38', 0, 1),
(107, '2024-07-11', 'SL-00107', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 10.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:56:45', '2024-07-11 05:56:45', 0, 1),
(108, '2024-07-11', 'SL-00108', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:58:06', '2024-07-11 05:58:06', 0, 1),
(109, '2024-07-11', 'SL-00109', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 155.00, 155.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 05:59:16', '2024-07-11 05:59:16', 0, 1),
(110, '2024-07-11', 'SL-00110', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 60.00, 60.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:01:08', '2024-07-11 06:01:08', 0, 1),
(111, '2024-07-11', 'SL-00111', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 60.00, 60.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:02:38', '2024-07-11 06:02:38', 0, 1),
(112, '2024-07-11', 'SL-00112', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:03:20', '2024-07-11 06:03:20', 0, 1),
(113, '2024-07-11', 'SL-00113', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 50.00, 50.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:03:48', '2024-07-11 06:03:48', 0, 1),
(114, '2024-07-11', 'SL-00114', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 50.00, 50.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:04:18', '2024-07-11 06:04:18', 0, 1),
(115, '2024-07-11', 'SL-00115', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 60.00, 60.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:04:54', '2024-07-11 06:04:54', 0, 1),
(116, '2024-07-11', 'SL-00116', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 10.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:05:32', '2024-07-11 06:05:32', 0, 1),
(117, '2024-07-11', 'SL-00117', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:05:54', '2024-07-11 06:05:54', 0, 1),
(118, '2024-07-11', 'SL-00118', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:06:19', '2024-07-11 06:06:19', 0, 1),
(119, '2024-07-11', 'SL-00119', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:10:20', '2024-07-11 06:10:20', 0, 1),
(120, '2024-07-11', 'SL-00120', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 10.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:14:18', '2024-07-11 06:14:18', 0, 1),
(121, '2024-07-11', 'SL-00121', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 10.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:14:45', '2024-07-11 06:14:45', 0, 1),
(122, '2024-07-11', 'SL-00122', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:17:43', '2024-07-11 06:17:43', 0, 1),
(123, '2024-07-11', 'SL-00123', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:20:42', '2024-07-11 06:20:42', 0, 1),
(124, '2024-07-11', 'SL-00124', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 50.00, 50.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:21:16', '2024-07-11 06:21:16', 0, 1),
(125, '2024-07-11', 'SL-00125', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 10.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:21:46', '2024-07-11 06:21:46', 0, 1),
(126, '2024-07-11', 'SL-00126', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 10.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:29:59', '2024-07-11 06:29:59', 0, 1),
(127, '2024-07-11', 'SL-00127', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 10.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:30:40', '2024-07-11 06:30:40', 0, 1),
(128, '2024-07-11', 'SL-00128', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:31:51', '2024-07-11 06:31:51', 0, 1),
(129, '2024-07-11', 'SL-00129', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:34:04', '2024-07-11 06:34:04', 0, 1),
(130, '2024-07-11', 'SL-00130', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 10.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 06:37:47', '2024-07-11 06:37:47', 0, 1),
(131, '2024-07-11', 'SL-00131', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 10.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 07:46:32', '2024-07-11 07:46:32', 0, 1),
(132, '2024-07-11', 'SL-00132', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 10.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 08:04:11', '2024-07-11 08:04:11', 0, 1),
(133, '2024-07-11', 'SL-00133', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 10.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 08:04:48', '2024-07-11 08:04:48', 0, 1),
(134, '2024-07-11', 'SL-00134', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 50.00, 50.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 08:05:09', '2024-07-11 08:05:09', 0, 1),
(135, '2024-07-11', 'SL-00135', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 40.00, 40.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 08:34:44', '2024-07-11 08:34:44', 0, 1),
(136, '2024-07-11', 'SL-00136', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 50.00, 50.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-11 08:36:33', '2024-07-11 08:36:33', 0, 1),
(137, '2024-07-12', 'SL-00137', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 50.00, 50.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-12 16:14:58', '2024-07-12 16:14:58', 0, 1),
(138, '2024-07-12', 'SL-00138', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 23.00, 23.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-07-12 17:29:17', '2024-07-12 17:29:17', 0, 1),
(139, '2024-07-23', 'SL-00139', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 10.00, 0.00, 10.00, 'Completed', 'Credit', 'Cash', NULL, NULL, NULL, '2024-07-23 08:25:01', '2024-07-23 08:25:01', 0, 1),
(140, '2024-10-19', 'SL-00140', 1, 'CS001', 1, 'walkin', 0, 0, 0, 0, 0, 60.00, 60.00, 0.00, 'Completed', 'Paid', 'Cash', NULL, NULL, NULL, '2024-10-19 02:55:55', '2024-10-19 02:55:55', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `sale_bulk_payments`
--

CREATE TABLE `sale_bulk_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference` varchar(255) NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `date` date DEFAULT NULL,
  `payment_method` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale_details`
--

CREATE TABLE `sale_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference` varchar(191) DEFAULT NULL,
  `sale_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `unit_price` int(11) NOT NULL,
  `sub_total` int(11) NOT NULL,
  `sale_type` varchar(191) DEFAULT NULL,
  `product_discount_amount` int(11) DEFAULT NULL,
  `product_discount_type` varchar(255) DEFAULT 'fixed',
  `product_tax_amount` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_details`
--

INSERT INTO `sale_details` (`id`, `reference`, `sale_id`, `product_id`, `product_name`, `product_code`, `quantity`, `price`, `unit_price`, `sub_total`, `sale_type`, `product_discount_amount`, `product_discount_type`, `product_tax_amount`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 1, 325, 'TROPICAL HEAT CHILLI LEMON 50G', '6161100910119', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 01:28:10', '2024-06-21 01:28:10', NULL),
(2, NULL, 2, 1099, 'BRAVA MANGO FRUIT  JUICE 300ML', '6164004075120', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-06-21 01:33:09', '2024-06-21 01:33:09', NULL),
(3, NULL, 2, 1229, 'SOFTCARE DIAPER LARGE PCS', 'PD1230', 3, 20, 20, 60, NULL, 0, 'fixed', 0, '2024-06-21 01:33:09', '2024-06-21 01:33:09', NULL),
(4, NULL, 3, 727, 'ZESTA RED PLUM JAM 100G', '6162000010015', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 01:35:15', '2024-06-21 01:35:15', NULL),
(5, NULL, 3, 43, 'NDOVU ALL PURPOSE FLOUR 2KG', '6161103620015', 1, 180, 180, 180, NULL, 0, 'fixed', 0, '2024-06-21 01:35:15', '2024-06-21 01:35:15', NULL),
(6, NULL, 4, 858, 'ZESTA TOMATO SAUCE 400G', '6162000020014', 1, 100, 100, 100, NULL, 0, 'fixed', 0, '2024-06-21 01:43:53', '2024-06-21 01:43:53', NULL),
(7, NULL, 4, 525, 'KCC MA,LA 500ML', '6161100461598', 1, 75, 75, 75, NULL, 0, 'fixed', 0, '2024-06-21 01:43:53', '2024-06-21 01:43:53', NULL),
(8, NULL, 5, 1816, 'BRAVA GUAVA JUICE 300ML', '6164004075144', 3, 50, 50, 150, NULL, 0, 'fixed', 0, '2024-06-21 02:04:27', '2024-06-21 02:04:27', NULL),
(9, NULL, 6, 1640, 'BIG HAPPY LEMONFLAVOUR', '6164002740372', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-06-21 02:23:08', '2024-06-21 02:23:08', NULL),
(10, NULL, 6, 1300, 'TWO TEN HOME BAKING FLOUR 1KG', '6164000726156', 1, 95, 95, 95, NULL, 0, 'fixed', 0, '2024-06-21 02:23:08', '2024-06-21 02:23:08', NULL),
(11, NULL, 7, 584, 'ROSY  EXTRA STRONG TISSUE', '6161100762411', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-06-21 02:38:39', '2024-06-21 02:38:39', NULL),
(12, NULL, 7, 981, 'VASELINE BABY PERFUMED JELLY 45 ML', '61614154', 1, 80, 80, 80, NULL, 0, 'fixed', 0, '2024-06-21 02:38:39', '2024-06-21 02:38:39', NULL),
(13, NULL, 7, 41, 'SOKO MAIZE MEAL 1KG', '6161102170030', 1, 75, 75, 75, NULL, 0, 'fixed', 0, '2024-06-21 02:38:39', '2024-06-21 02:38:39', NULL),
(14, NULL, 7, 689, 'DOUGHNUTS CAKES  600G', 'PD0690', 1, 60, 60, 60, NULL, 0, 'fixed', 0, '2024-06-21 02:38:39', '2024-06-21 02:38:39', NULL),
(15, NULL, 7, 472, 'DAIRY JOY MILK', 'PD0473', 1, 35, 35, 35, NULL, 0, 'fixed', 0, '2024-06-21 02:38:39', '2024-06-21 02:38:39', NULL),
(16, NULL, 8, 1594, 'FAMILA PURE WIMBI 500G', '6161100450134', 1, 90, 90, 90, NULL, 0, 'fixed', 0, '2024-06-21 13:09:54', '2024-06-21 13:09:54', NULL),
(17, NULL, 9, 1884, 'CHOCOLATEE', '6164000658631', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-06-21 13:23:50', '2024-06-21 13:23:50', NULL),
(18, NULL, 9, 1883, 'TOOGOODY TOFFEE', '6161103032412', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-06-21 13:23:50', '2024-06-21 13:23:50', NULL),
(19, NULL, 10, 1885, 'MULTSTARS 18G', '6223005591241', 1, 25, 25, 25, NULL, 0, 'fixed', 0, '2024-06-21 13:34:45', '2024-06-21 13:34:45', NULL),
(20, NULL, 10, 1830, 'WAVES SALT& VINEGAR CRISPS 30G', '6161100910409', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-06-21 13:34:45', '2024-06-21 13:34:45', NULL),
(21, NULL, 11, 4, 'AJAB FORTIFIED ALL PURPOSE HOME BAKING FLOUR 2KG', '6161113940141', 1, 200, 200, 200, NULL, 0, 'fixed', 0, '2024-06-21 13:55:37', '2024-06-21 13:55:37', NULL),
(22, NULL, 12, 106, 'WEETABIX ORIGINAL 37G', '5010029205084', 1, 30, 30, 30, NULL, 0, 'fixed', 0, '2024-06-21 14:39:06', '2024-06-21 14:39:06', NULL),
(23, NULL, 12, 291, 'WHITE WASH WHITE 175G', '6009635140970', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-06-21 14:39:06', '2024-06-21 14:39:06', NULL),
(24, NULL, 12, 1229, 'SOFTCARE DIAPER LARGE PCS', 'PD1230', 2, 20, 20, 40, NULL, 0, 'fixed', 0, '2024-06-21 14:39:06', '2024-06-21 14:39:06', NULL),
(25, NULL, 13, 78, 'KENSALT  200G', '6161101280037', 1, 20, 20, 20, NULL, 0, 'fixed', 0, '2024-06-21 14:41:04', '2024-06-21 14:41:04', NULL),
(26, NULL, 14, 294, 'BROOKSIDE SWEET LALA 500ML', '6161107150709', 1, 100, 100, 100, NULL, 0, 'fixed', 0, '2024-06-21 14:42:13', '2024-06-21 14:42:13', NULL),
(27, NULL, 15, 60, 'COLGATE REGULAR 70G', '8850006324387', 1, 130, 130, 130, NULL, 0, 'fixed', 0, '2024-06-21 14:44:28', '2024-06-21 14:44:28', NULL),
(28, NULL, 16, 385, 'FANTA BLACK CURRENT 2L', '5449000022752', 1, 200, 200, 200, NULL, 0, 'fixed', 0, '2024-06-21 14:53:52', '2024-06-21 14:53:52', NULL),
(29, NULL, 17, 694, 'BELLA WHITE 2 ROLLS', '6164000242540', 1, 80, 80, 80, NULL, 0, 'fixed', 0, '2024-06-21 15:01:22', '2024-06-21 15:01:22', NULL),
(30, NULL, 18, 503, 'BROADWAYS WHITE BREAD 400G', '6166000001721', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 15:04:24', '2024-06-21 15:04:24', NULL),
(31, NULL, 18, 326, 'TROPICAL HEAT TOMATO 50G', '6161100914582', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 15:04:24', '2024-06-21 15:04:24', NULL),
(32, NULL, 18, 1208, 'KISMAT POPCORN 30G', '6164002547018', 1, 30, 30, 30, NULL, 0, 'fixed', 0, '2024-06-21 15:04:24', '2024-06-21 15:04:24', NULL),
(33, NULL, 18, 1821, 'TUZO YOGHURT STRAWBERRY 200G', '6161107151744', 1, 60, 60, 60, NULL, 0, 'fixed', 0, '2024-06-21 15:04:24', '2024-06-21 15:04:24', NULL),
(34, NULL, 18, 1260, 'SPRITE 350ML', '40822099', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-06-21 15:04:24', '2024-06-21 15:04:24', NULL),
(35, NULL, 19, 1671, 'NDOVU ALL PURPOSE FLOUR 500ML', '6161103620114', 2, 55, 55, 110, NULL, 0, 'fixed', 0, '2024-06-21 15:05:35', '2024-06-21 15:05:35', NULL),
(36, NULL, 20, 744, 'KIWI 15ML/12G', '61602212', 1, 60, 60, 60, NULL, 0, 'fixed', 0, '2024-06-21 15:15:11', '2024-06-21 15:15:11', NULL),
(37, NULL, 21, 1229, 'SOFTCARE DIAPER LARGE PCS', 'PD1230', 3, 20, 20, 60, NULL, 0, 'fixed', 0, '2024-06-21 15:16:13', '2024-06-21 15:16:13', NULL),
(38, NULL, 22, 764, 'PK BLUE', 'PD0765', 5, 10, 10, 50, NULL, 0, 'fixed', 0, '2024-06-21 15:27:50', '2024-06-21 15:27:50', NULL),
(39, NULL, 23, 291, 'WHITE WASH WHITE 175G', '6009635140970', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-06-21 15:38:25', '2024-06-21 15:38:25', NULL),
(40, NULL, 24, 173, 'FANTA ORANGE 1.25L', '5449000028938', 1, 140, 140, 140, NULL, 0, 'fixed', 0, '2024-06-21 15:41:31', '2024-06-21 15:41:31', NULL),
(41, NULL, 24, 1890, 'PINPOP', 'IT01890', 1, 15, 15, 15, NULL, 0, 'fixed', 0, '2024-06-21 15:41:31', '2024-06-21 15:41:31', NULL),
(42, NULL, 25, 131, 'SUPALOAF 400G', '6161102320404', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 15:42:36', '2024-06-21 15:42:36', NULL),
(43, NULL, 26, 295, 'FESTIVE BREAD 400G', '6161105070238', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 15:43:56', '2024-06-21 15:43:56', NULL),
(44, NULL, 27, 1889, 'SALAD 1L', 'IT01889', 0, 230, 230, 50, NULL, 0, 'fixed', 0, '2024-06-21 15:46:19', '2024-06-21 15:46:19', NULL),
(45, NULL, 28, 1469, 'TOMATOPASTESANTAMARIA70G', '6164004454901', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-06-21 15:47:50', '2024-06-21 15:47:50', NULL),
(46, NULL, 28, 131, 'SUPALOAF 400G', '6161102320404', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 15:47:50', '2024-06-21 15:47:50', NULL),
(47, NULL, 28, 331, 'EARBUDS CHICO', 'PD0331', 1, 20, 20, 20, NULL, 0, 'fixed', 0, '2024-06-21 15:47:50', '2024-06-21 15:47:50', NULL),
(48, NULL, 29, 158, 'MOUNT KENYA MILK 500ML', '6161100100084', 4, 60, 60, 240, NULL, 0, 'fixed', 0, '2024-06-21 15:49:52', '2024-06-21 15:49:52', NULL),
(49, NULL, 29, 452, 'SUPA LOAF WHITE BREAD 800G', '6161102320183', 1, 130, 130, 130, NULL, 0, 'fixed', 0, '2024-06-21 15:49:52', '2024-06-21 15:49:52', NULL),
(50, NULL, 30, 488, 'AFIA MIXED FRUIT 500ML', '6008459000972', 1, 80, 80, 80, NULL, 0, 'fixed', 0, '2024-06-21 15:50:54', '2024-06-21 15:50:54', NULL),
(51, NULL, 30, 278, 'CHAPA MANDASHI  100G', '6161101661713', 1, 35, 35, 35, NULL, 0, 'fixed', 0, '2024-06-21 15:50:54', '2024-06-21 15:50:54', NULL),
(52, NULL, 31, 639, 'SAWA MUFFIN  6PCS 300G', '792382560936', 1, 130, 130, 130, NULL, 0, 'fixed', 0, '2024-06-21 15:52:06', '2024-06-21 15:52:06', NULL),
(53, NULL, 31, 158, 'MOUNT KENYA MILK 500ML', '6161100100084', 1, 60, 60, 60, NULL, 0, 'fixed', 0, '2024-06-21 15:52:06', '2024-06-21 15:52:06', NULL),
(54, NULL, 31, 370, 'CARRIER BAG #22', 'PD0370', 1, 20, 20, 20, NULL, 0, 'fixed', 0, '2024-06-21 15:52:06', '2024-06-21 15:52:06', NULL),
(55, NULL, 32, 2, 'SOKO MAIZE MEAL 2KG', '6161102170023', 1, 145, 145, 145, NULL, 0, 'fixed', 0, '2024-06-21 15:56:47', '2024-06-21 15:56:47', NULL),
(56, NULL, 32, 1889, 'SALAD 1L', 'IT01889', 1, 230, 230, 150, NULL, 0, 'fixed', 0, '2024-06-21 15:56:48', '2024-06-21 15:56:48', NULL),
(57, NULL, 32, 1890, 'PINPOP', 'IT01890', 1, 15, 15, 15, NULL, 0, 'fixed', 0, '2024-06-21 15:56:48', '2024-06-21 15:56:48', NULL),
(58, NULL, 33, 278, 'CHAPA MANDASHI  100G', '6161101661713', 1, 35, 35, 35, NULL, 0, 'fixed', 0, '2024-06-21 16:03:13', '2024-06-21 16:03:13', NULL),
(59, NULL, 34, 158, 'MOUNT KENYA MILK 500ML', '6161100100084', 1, 60, 60, 60, NULL, 0, 'fixed', 0, '2024-06-21 16:07:10', '2024-06-21 16:07:10', NULL),
(60, NULL, 34, 41, 'SOKO MAIZE MEAL 1KG', '6161102170030', 1, 75, 75, 75, NULL, 0, 'fixed', 0, '2024-06-21 16:07:10', '2024-06-21 16:07:10', NULL),
(61, NULL, 35, 1380, 'MORTEIN DOOM INSECT KILLER 100ML', '6161100952256', 1, 240, 240, 240, NULL, 0, 'fixed', 0, '2024-06-21 16:11:07', '2024-06-21 16:11:07', NULL),
(62, NULL, 35, 325, 'TROPICAL HEAT CHILLI LEMON 50G', '6161100910119', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 16:11:07', '2024-06-21 16:11:07', NULL),
(63, NULL, 36, 117, 'BROOKSIDE FARM FRESH 200ML', '6161101000444', 1, 35, 35, 35, NULL, 0, 'fixed', 0, '2024-06-21 16:13:56', '2024-06-21 16:13:56', NULL),
(64, NULL, 36, 1021, 'LATO MILK 125ML', '6164002812628', 1, 25, 25, 25, NULL, 0, 'fixed', 0, '2024-06-21 16:13:56', '2024-06-21 16:13:56', NULL),
(65, NULL, 36, 295, 'FESTIVE BREAD 400G', '6161105070238', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 16:13:56', '2024-06-21 16:13:56', NULL),
(66, NULL, 37, 574, 'MSAFI  WHITE WASHING POWDER LAVENDER FRESH 500G', '6161117772069', 1, 140, 140, 140, NULL, 0, 'fixed', 0, '2024-06-21 16:15:03', '2024-06-21 16:15:03', NULL),
(67, NULL, 38, 231, 'LATO MILK 500ML', '6164002812109', 1, 60, 60, 60, NULL, 0, 'fixed', 0, '2024-06-21 16:15:46', '2024-06-21 16:15:46', NULL),
(68, NULL, 39, 503, 'BROADWAYS WHITE BREAD 400G', '6166000001721', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 16:17:22', '2024-06-21 16:17:22', NULL),
(69, NULL, 39, 1817, 'BROOKSIDE NATURAL LALA 1000G', '6161107151775', 1, 185, 185, 185, NULL, 0, 'fixed', 0, '2024-06-21 16:17:22', '2024-06-21 16:17:22', NULL),
(70, NULL, 39, 369, 'CARRIER BAG #15', 'PD0369', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-06-21 16:17:22', '2024-06-21 16:17:22', NULL),
(71, NULL, 40, 1540, 'UFRESH JUICE', '6034000117783', 2, 25, 25, 50, NULL, 0, 'fixed', 0, '2024-06-21 16:19:14', '2024-06-21 16:19:14', NULL),
(72, NULL, 41, 1540, 'UFRESH JUICE', '6034000117783', 1, 25, 25, 25, NULL, 0, 'fixed', 0, '2024-06-21 16:20:31', '2024-06-21 16:20:31', NULL),
(73, NULL, 42, 158, 'MOUNT KENYA MILK 500ML', '6161100100084', 1, 60, 60, 60, NULL, 0, 'fixed', 0, '2024-06-21 16:24:30', '2024-06-21 16:24:30', NULL),
(74, NULL, 42, 500, 'AMERU COATED PEANUTS 20G', '6164003851206', 5, 10, 10, 50, NULL, 0, 'fixed', 0, '2024-06-21 16:24:30', '2024-06-21 16:24:30', NULL),
(75, NULL, 43, 1889, 'SALAD 1L', 'IT01889', 1, 230, 230, 200, NULL, 0, 'fixed', 0, '2024-06-21 16:26:26', '2024-06-21 16:26:26', NULL),
(76, NULL, 44, 42, 'PEMBE MAIZE MEAL 2KG', '6009627050010', 1, 145, 145, 145, NULL, 0, 'fixed', 0, '2024-06-21 16:30:54', '2024-06-21 16:30:54', NULL),
(77, NULL, 44, 610, 'TWO TEN SIFTED MAIZE MEAL 2KG', '6164000726170', 1, 145, 145, 145, NULL, 0, 'fixed', 0, '2024-06-21 16:30:54', '2024-06-21 16:30:54', NULL),
(78, NULL, 44, 328, 'DAWN PEKEE QUALITY ROLL', '6161100760226', 1, 35, 35, 35, NULL, 0, 'fixed', 0, '2024-06-21 16:30:54', '2024-06-21 16:30:54', NULL),
(79, NULL, 45, 69, 'FAHARI YA KENYA 50G', '6009629720072', 1, 25, 25, 25, NULL, 0, 'fixed', 0, '2024-06-21 16:47:19', '2024-06-21 16:47:19', NULL),
(80, NULL, 46, 1812, '210 MAIZE ,MEAL 1KG', '6164000726187', 1, 75, 75, 75, NULL, 0, 'fixed', 0, '2024-06-21 17:04:59', '2024-06-21 17:04:59', NULL),
(81, NULL, 47, 563, 'KINGSMILL BREAD 200G', '6161103150703', 1, 35, 35, 35, NULL, 0, 'fixed', 0, '2024-06-21 17:07:59', '2024-06-21 17:07:59', NULL),
(82, NULL, 47, 1385, 'TUZO ESL MILK 200ML', '6161101680431', 1, 30, 30, 30, NULL, 0, 'fixed', 0, '2024-06-21 17:07:59', '2024-06-21 17:07:59', NULL),
(83, NULL, 48, 1812, '210 MAIZE ,MEAL 1KG', '6164000726187', 1, 75, 75, 75, NULL, 0, 'fixed', 0, '2024-06-21 17:08:39', '2024-06-21 17:08:39', NULL),
(84, NULL, 49, 1471, 'PROBIOTIC  YOGHURT STRAWBERRIES  450G', '6161107151485', 1, 160, 160, 160, NULL, 0, 'fixed', 0, '2024-06-21 17:15:06', '2024-06-21 17:15:06', NULL),
(85, NULL, 49, 336, 'DELAMERE LEMON BISCUIT 450G', '6164000033193', 1, 150, 150, 150, NULL, 0, 'fixed', 0, '2024-06-21 17:15:06', '2024-06-21 17:15:06', NULL),
(86, NULL, 49, 642, 'QUEEN CAKE 8PCS 200G', '792382565467', 1, 80, 80, 80, NULL, 0, 'fixed', 0, '2024-06-21 17:15:06', '2024-06-21 17:15:06', NULL),
(87, NULL, 49, 641, 'QUEEN CAKE 6PCS 260G', '792382560950', 2, 95, 95, 190, NULL, 0, 'fixed', 0, '2024-06-21 17:15:06', '2024-06-21 17:15:06', NULL),
(88, NULL, 50, 133, 'FESTIVE BROWN BREAD 400G', '6161105070252', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 17:16:23', '2024-06-21 17:16:23', NULL),
(89, NULL, 51, 320, 'TROPICAL HEAT CHILLI LEMON CRIPS 100G', '6161100910126', 1, 110, 110, 110, NULL, 0, 'fixed', 0, '2024-06-21 17:17:32', '2024-06-21 17:17:32', NULL),
(90, NULL, 51, 295, 'FESTIVE BREAD 400G', '6161105070238', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 17:17:32', '2024-06-21 17:17:32', NULL),
(91, NULL, 52, 524, 'BROADWAYS BROWN 400G', '6166000001738', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 17:19:49', '2024-06-21 17:19:49', NULL),
(92, NULL, 52, 503, 'BROADWAYS WHITE BREAD 400G', '6166000001721', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 17:19:49', '2024-06-21 17:19:49', NULL),
(93, NULL, 52, 232, 'BROOKSIDEMILK 500ML', '6161101000543', 1, 65, 65, 65, NULL, 0, 'fixed', 0, '2024-06-21 17:19:49', '2024-06-21 17:19:49', NULL),
(94, NULL, 52, 157, 'MOUNT KENYA MILK 200ML', '6161100100107', 1, 30, 30, 30, NULL, 0, 'fixed', 0, '2024-06-21 17:19:49', '2024-06-21 17:19:49', NULL),
(95, NULL, 53, 373, 'MINUTE MAID DELIGHT APPLE DRINK 1 L', '5449000180292', 1, 190, 190, 190, NULL, 0, 'fixed', 0, '2024-06-21 17:20:38', '2024-06-21 17:20:38', NULL),
(96, NULL, 54, 1229, 'SOFTCARE DIAPER LARGE PCS', 'PD1230', 1, 20, 20, 20, NULL, 0, 'fixed', 0, '2024-06-21 17:23:14', '2024-06-21 17:23:14', NULL),
(97, NULL, 55, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-06-21 17:34:05', '2024-06-21 17:34:05', NULL),
(98, NULL, 56, 1665, 'COLGATE 2IN1 TOOTHBRUSH', '6001067001485', 1, 140, 140, 140, NULL, 0, 'fixed', 0, '2024-06-21 17:36:05', '2024-06-21 17:36:05', NULL),
(99, NULL, 62, 43, 'NDOVU ALL PURPOSE FLOUR 2KG', '6161103620015', 2, 180, 180, 360, NULL, 0, 'fixed', 0, '2024-06-21 17:38:09', '2024-06-21 17:38:09', NULL),
(100, NULL, 64, 1260, 'SPRITE 350ML', '40822099', 2, 50, 50, 100, NULL, 0, 'fixed', 0, '2024-06-21 17:39:33', '2024-06-21 17:39:33', NULL),
(101, NULL, 69, 1403, 'N\'GOES PEANUT', '8683960000772', 2, 95, 95, 190, NULL, 0, 'fixed', 0, '2024-06-21 17:44:26', '2024-06-21 17:44:26', NULL),
(102, NULL, 69, 1467, 'EARBUDS PRETTY', 'PD1468', 1, 30, 30, 30, NULL, 0, 'fixed', 0, '2024-06-21 17:44:26', '2024-06-21 17:44:26', NULL),
(103, NULL, 69, 94, 'ROYCO BEEF CUBE', '6162006602610', 1, 130, 130, 130, NULL, 0, 'fixed', 0, '2024-06-21 17:44:26', '2024-06-21 17:44:26', NULL),
(108, NULL, 84, 5, 'SAFI 500ML ', 'PD0005', 1, 20, 20, 20, NULL, 0, 'fixed', 0, '2024-06-22 07:15:17', '2024-06-22 07:15:17', NULL),
(109, NULL, 88, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-06-22 07:21:14', '2024-06-22 07:21:14', NULL),
(110, NULL, 89, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-06-22 07:27:12', '2024-06-22 07:27:12', NULL),
(111, NULL, 89, 2, 'SOKO MAIZE MEAL 2KG', '6161102170023', 1, 145, 145, 145, NULL, 0, 'fixed', 0, '2024-06-22 07:27:12', '2024-06-22 07:27:12', NULL),
(112, NULL, 89, 1, '210 2KG SIFTED MAIZE MEAL', 'PD0001', 1, 160, 160, 160, NULL, 0, 'fixed', 0, '2024-06-22 07:27:12', '2024-06-22 07:27:12', NULL),
(113, NULL, 89, 5, 'SAFI 500ML ', 'PD0005', 1, 20, 20, 20, NULL, 0, 'fixed', 0, '2024-06-22 07:27:12', '2024-06-22 07:27:12', NULL),
(118, NULL, 92, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 05:16:16', '2024-07-11 05:16:16', NULL),
(119, NULL, 92, 2, 'SOKO MAIZE MEAL 2KG', '6161102170023', 1, 145, 145, 145, NULL, 0, 'fixed', 0, '2024-07-11 05:16:16', '2024-07-11 05:16:16', NULL),
(120, NULL, 93, 9, 'FANTA BLACKCURRANT  350ML', '42116479', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-07-11 05:27:06', '2024-07-11 05:27:06', NULL),
(121, NULL, 93, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 05:27:06', '2024-07-11 05:27:06', NULL),
(122, NULL, 95, 9, 'FANTA BLACKCURRANT  350ML', '42116479', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-07-11 05:28:47', '2024-07-11 05:28:47', NULL),
(123, NULL, 96, 9, 'FANTA BLACKCURRANT  350ML', '42116479', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-07-11 05:31:54', '2024-07-11 05:31:54', NULL),
(124, NULL, 97, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 05:42:23', '2024-07-11 05:42:23', NULL),
(125, NULL, 97, 5, 'SAFI 500ML ', 'PD0005', 1, 20, 20, 20, NULL, 0, 'fixed', 0, '2024-07-11 05:42:23', '2024-07-11 05:42:23', NULL),
(126, NULL, 99, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 05:43:34', '2024-07-11 05:43:34', NULL),
(127, NULL, 101, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 05:51:48', '2024-07-11 05:51:48', NULL),
(128, NULL, 102, 5, 'SAFI 500ML ', 'PD0005', 1, 20, 20, 20, NULL, 0, 'fixed', 0, '2024-07-11 05:54:03', '2024-07-11 05:54:03', NULL),
(129, NULL, 104, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 05:55:02', '2024-07-11 05:55:02', NULL),
(130, NULL, 104, 2, 'SOKO MAIZE MEAL 2KG', '6161102170023', 1, 145, 145, 145, NULL, 0, 'fixed', 0, '2024-07-11 05:55:02', '2024-07-11 05:55:02', NULL),
(131, NULL, 105, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 05:55:28', '2024-07-11 05:55:28', NULL),
(132, NULL, 105, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 05:55:28', '2024-07-11 05:55:28', NULL),
(133, NULL, 106, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 05:56:38', '2024-07-11 05:56:38', NULL),
(134, NULL, 108, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 05:58:06', '2024-07-11 05:58:06', NULL),
(135, NULL, 109, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 05:59:16', '2024-07-11 05:59:16', NULL),
(136, NULL, 109, 2, 'SOKO MAIZE MEAL 2KG', '6161102170023', 1, 145, 145, 145, NULL, 0, 'fixed', 0, '2024-07-11 05:59:16', '2024-07-11 05:59:16', NULL),
(137, NULL, 110, 8, 'SPRITE LEMON LIME 500ML', '54491069', 1, 60, 60, 60, NULL, 0, 'fixed', 0, '2024-07-11 06:01:08', '2024-07-11 06:01:08', NULL),
(138, NULL, 111, 8, 'SPRITE LEMON LIME 500ML', '54491069', 1, 60, 60, 60, NULL, 0, 'fixed', 0, '2024-07-11 06:02:38', '2024-07-11 06:02:38', NULL),
(139, NULL, 112, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 06:03:20', '2024-07-11 06:03:20', NULL),
(140, NULL, 113, 9, 'FANTA BLACKCURRANT  350ML', '42116479', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-07-11 06:03:48', '2024-07-11 06:03:48', NULL),
(141, NULL, 114, 9, 'FANTA BLACKCURRANT  350ML', '42116479', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-07-11 06:04:18', '2024-07-11 06:04:18', NULL),
(142, NULL, 115, 9, 'FANTA BLACKCURRANT  350ML', '42116479', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-07-11 06:04:54', '2024-07-11 06:04:54', NULL),
(143, NULL, 115, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 06:04:54', '2024-07-11 06:04:54', NULL),
(144, NULL, 116, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 06:05:32', '2024-07-11 06:05:32', NULL),
(145, NULL, 117, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 06:05:54', '2024-07-11 06:05:54', NULL),
(146, NULL, 118, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 06:06:19', '2024-07-11 06:06:19', NULL),
(147, NULL, 119, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 06:10:20', '2024-07-11 06:10:20', NULL),
(148, NULL, 120, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 06:14:18', '2024-07-11 06:14:18', NULL),
(149, NULL, 121, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 06:14:45', '2024-07-11 06:14:45', NULL),
(150, NULL, 122, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 06:17:43', '2024-07-11 06:17:43', NULL),
(151, NULL, 123, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 06:20:42', '2024-07-11 06:20:42', NULL),
(152, NULL, 124, 9, 'FANTA BLACKCURRANT  350ML', '42116479', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-07-11 06:21:16', '2024-07-11 06:21:16', NULL),
(153, NULL, 125, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 06:21:46', '2024-07-11 06:21:46', NULL),
(154, NULL, 126, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 06:29:59', '2024-07-11 06:29:59', NULL),
(155, NULL, 127, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 06:30:40', '2024-07-11 06:30:40', NULL),
(156, NULL, 128, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 06:31:51', '2024-07-11 06:31:51', NULL),
(157, NULL, 129, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 06:34:04', '2024-07-11 06:34:04', NULL),
(158, NULL, 130, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 06:37:47', '2024-07-11 06:37:47', NULL),
(159, NULL, 131, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 07:46:32', '2024-07-11 07:46:32', NULL),
(160, NULL, 132, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 08:04:11', '2024-07-11 08:04:11', NULL),
(161, NULL, 133, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 08:04:48', '2024-07-11 08:04:48', NULL),
(162, NULL, 134, 9, 'FANTA BLACKCURRANT  350ML', '42116479', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-07-11 08:05:09', '2024-07-11 08:05:09', NULL),
(163, NULL, 135, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 08:34:44', '2024-07-11 08:34:44', NULL),
(164, NULL, 136, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-11 08:36:33', '2024-07-11 08:36:33', NULL),
(165, NULL, 136, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-11 08:36:33', '2024-07-11 08:36:33', NULL),
(166, NULL, 137, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-12 16:14:58', '2024-07-12 16:14:58', NULL),
(167, NULL, 137, 6, 'SAFI 1LTR', 'PD0006', 1, 40, 40, 40, NULL, 0, 'fixed', 0, '2024-07-12 16:14:58', '2024-07-12 16:14:58', NULL),
(168, NULL, 138, 3, 'RINGOZ BARBEQUE', '6161114160128', 2, 10, 10, 22, NULL, 0, 'fixed', 0, '2024-07-12 17:29:17', '2024-07-12 17:29:17', NULL),
(169, NULL, 139, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-07-23 08:25:01', '2024-07-23 08:25:01', NULL),
(170, NULL, 140, 3, 'RINGOZ BARBEQUE', '6161114160128', 1, 10, 10, 10, NULL, 0, 'fixed', 0, '2024-10-19 02:55:55', '2024-10-19 02:55:55', NULL),
(171, NULL, 140, 9, 'FANTA BLACKCURRANT  350ML', '42116479', 1, 50, 50, 50, NULL, 0, 'fixed', 0, '2024-10-19 02:55:55', '2024-10-19 02:55:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sale_payments`
--

CREATE TABLE `sale_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_code` varchar(191) DEFAULT NULL,
  `amount` decimal(8,2) NOT NULL,
  `date` date NOT NULL,
  `reference` varchar(255) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_payments`
--

INSERT INTO `sale_payments` (`id`, `sale_id`, `customer_code`, `amount`, `date`, `reference`, `payment_method`, `note`, `created_at`, `updated_at`, `deleted_at`) VALUES
(9, 1, 'CS001', 65.00, '2024-06-21', 'INV/SL-00001', 'Cash', NULL, '2024-06-21 01:28:10', '2024-06-21 01:28:10', NULL),
(10, 2, 'CS001', 110.00, '2024-06-21', 'INV/SL-00002', 'Cash', NULL, '2024-06-21 01:33:09', '2024-06-21 01:33:09', NULL),
(11, 3, 'CS001', 245.00, '2024-06-21', 'INV/SL-00003', 'Cash', NULL, '2024-06-21 01:35:15', '2024-06-21 01:35:15', NULL),
(12, 4, 'CS001', 175.00, '2024-06-21', 'INV/SL-00004', 'Cash', NULL, '2024-06-21 01:43:53', '2024-06-21 01:43:53', NULL),
(13, 5, 'CS001', 150.00, '2024-06-21', 'INV/SL-00005', 'Cash', NULL, '2024-06-21 02:04:27', '2024-06-21 02:04:27', NULL),
(14, 6, 'CS001', 105.00, '2024-06-21', 'INV/SL-00006', 'Cash', NULL, '2024-06-21 02:23:08', '2024-06-21 02:23:08', NULL),
(15, 7, 'CS001', 290.00, '2024-06-21', 'INV/SL-00007', 'Cash', NULL, '2024-06-21 02:38:39', '2024-06-21 02:38:39', NULL),
(16, 9, 'CS001', 20.00, '2024-06-21', 'INV/SL-00009', 'Cash', NULL, '2024-06-21 13:23:50', '2024-06-21 13:23:50', NULL),
(17, 8, NULL, 90.00, '2024-06-21', 'INV/SL-00008', 'Cash', NULL, '2024-06-21 13:28:57', '2024-06-21 13:28:57', NULL),
(18, 10, 'CS001', 75.00, '2024-06-21', 'INV/SL-00010', 'Cash', NULL, '2024-06-21 13:34:45', '2024-06-21 13:34:45', NULL),
(19, 11, 'CS001', 200.00, '2024-06-21', 'INV/SL-00011', 'Mpesa', NULL, '2024-06-21 13:55:37', '2024-06-21 13:55:37', NULL),
(20, 12, 'CS001', 120.00, '2024-06-21', 'INV/SL-00012', 'Cash', NULL, '2024-06-21 14:39:06', '2024-06-21 14:39:06', NULL),
(21, 13, 'CS001', 20.00, '2024-06-21', 'INV/SL-00013', 'Cash', NULL, '2024-06-21 14:41:04', '2024-06-21 14:41:04', NULL),
(22, 14, 'CS001', 100.00, '2024-06-21', 'INV/SL-00014', 'Cash', NULL, '2024-06-21 14:42:13', '2024-06-21 14:42:13', NULL),
(23, 15, 'CS001', 130.00, '2024-06-21', 'INV/SL-00015', 'Cash', NULL, '2024-06-21 14:44:28', '2024-06-21 14:44:28', NULL),
(24, 16, 'CS001', 200.00, '2024-06-21', 'INV/SL-00016', 'Cash', NULL, '2024-06-21 14:53:52', '2024-06-21 14:53:52', NULL),
(25, 17, 'CS001', 80.00, '2024-06-21', 'INV/SL-00017', 'Cash', NULL, '2024-06-21 15:01:22', '2024-06-21 15:01:22', NULL),
(26, 18, 'CS001', 270.00, '2024-06-21', 'INV/SL-00018', 'Mpesa', NULL, '2024-06-21 15:04:24', '2024-06-21 15:04:24', NULL),
(27, 19, 'CS001', 110.00, '2024-06-21', 'INV/SL-00019', 'Cash', NULL, '2024-06-21 15:05:35', '2024-06-21 15:05:35', NULL),
(28, 20, 'CS001', 60.00, '2024-06-21', 'INV/SL-00020', 'Cash', NULL, '2024-06-21 15:15:11', '2024-06-21 15:15:11', NULL),
(29, 21, 'CS001', 60.00, '2024-06-21', 'INV/SL-00021', 'Cash', NULL, '2024-06-21 15:16:13', '2024-06-21 15:16:13', NULL),
(30, 22, 'CS001', 50.00, '2024-06-21', 'INV/SL-00022', 'Mpesa', NULL, '2024-06-21 15:27:50', '2024-06-21 15:27:50', NULL),
(31, 23, 'CS001', 50.00, '2024-06-21', 'INV/SL-00023', 'Mpesa', NULL, '2024-06-21 15:38:25', '2024-06-21 15:38:25', NULL),
(32, 24, 'CS001', 155.00, '2024-06-21', 'INV/SL-00024', 'Cash', NULL, '2024-06-21 15:41:31', '2024-06-21 15:41:31', NULL),
(33, 25, 'CS001', 65.00, '2024-06-21', 'INV/SL-00025', 'Cash', NULL, '2024-06-21 15:42:36', '2024-06-21 15:42:36', NULL),
(34, 26, 'CS001', 65.00, '2024-06-21', 'INV/SL-00026', 'Mpesa', NULL, '2024-06-21 15:43:56', '2024-06-21 15:43:56', NULL),
(35, 27, 'CS001', 49.91, '2024-06-21', 'INV/SL-00027', 'Cash', NULL, '2024-06-21 15:46:19', '2024-06-21 15:46:19', NULL),
(36, 28, 'CS001', 135.00, '2024-06-21', 'INV/SL-00028', 'Mpesa', NULL, '2024-06-21 15:47:50', '2024-06-21 15:47:50', NULL),
(37, 29, 'CS001', 370.00, '2024-06-21', 'INV/SL-00029', 'Cash', NULL, '2024-06-21 15:49:52', '2024-06-21 15:49:52', NULL),
(38, 30, 'CS001', 115.00, '2024-06-21', 'INV/SL-00030', 'Mpesa', NULL, '2024-06-21 15:50:54', '2024-06-21 15:50:54', NULL),
(39, 31, 'CS001', 210.00, '2024-06-21', 'INV/SL-00031', 'Cash', NULL, '2024-06-21 15:52:06', '2024-06-21 15:52:06', NULL),
(40, 32, 'CS001', 309.96, '2024-06-21', 'INV/SL-00032', 'Mpesa', NULL, '2024-06-21 15:56:48', '2024-06-21 15:56:48', NULL),
(41, 33, 'CS001', 35.00, '2024-06-21', 'INV/SL-00033', 'Mpesa', NULL, '2024-06-21 16:03:13', '2024-06-21 16:03:13', NULL),
(42, 34, 'CS001', 135.00, '2024-06-21', 'INV/SL-00034', 'Cash', NULL, '2024-06-21 16:07:10', '2024-06-21 16:07:10', NULL),
(43, 35, 'CS001', 305.00, '2024-06-21', 'INV/SL-00035', 'Cash', NULL, '2024-06-21 16:11:07', '2024-06-21 16:11:07', NULL),
(44, 36, 'CS001', 125.00, '2024-06-21', 'INV/SL-00036', 'Cash', NULL, '2024-06-21 16:13:56', '2024-06-21 16:13:56', NULL),
(45, 37, 'CS001', 140.00, '2024-06-21', 'INV/SL-00037', 'Cash', NULL, '2024-06-21 16:15:03', '2024-06-21 16:15:03', NULL),
(46, 38, 'CS001', 60.00, '2024-06-21', 'INV/SL-00038', 'Cash', NULL, '2024-06-21 16:15:46', '2024-06-21 16:15:46', NULL),
(47, 39, 'CS001', 260.00, '2024-06-21', 'INV/SL-00039', 'Mpesa', NULL, '2024-06-21 16:17:22', '2024-06-21 16:17:22', NULL),
(48, 41, 'CS001', 25.00, '2024-06-21', 'INV/SL-00041', 'Cash', NULL, '2024-06-21 16:20:31', '2024-06-21 16:20:31', NULL),
(49, 40, NULL, 25.00, '2024-06-21', 'INV/SL-00040', 'Cash', NULL, '2024-06-21 16:22:02', '2024-06-21 16:22:02', NULL),
(50, 42, 'CS001', 110.00, '2024-06-21', 'INV/SL-00042', 'Mpesa', NULL, '2024-06-21 16:24:30', '2024-06-21 16:24:30', NULL),
(51, 43, 'CS001', 200.00, '2024-06-21', 'INV/SL-00043', 'Mpesa', NULL, '2024-06-21 16:26:26', '2024-06-21 16:26:26', NULL),
(52, 44, 'CS001', 325.00, '2024-06-21', 'INV/SL-00044', 'Cash', NULL, '2024-06-21 16:30:54', '2024-06-21 16:30:54', NULL),
(53, 45, 'CS001', 25.00, '2024-06-21', 'INV/SL-00045', 'Mpesa', NULL, '2024-06-21 16:47:19', '2024-06-21 16:47:19', NULL),
(54, 46, 'CS001', 75.00, '2024-06-21', 'INV/SL-00046', 'Mpesa', NULL, '2024-06-21 17:04:59', '2024-06-21 17:04:59', NULL),
(55, 47, 'CS001', 65.00, '2024-06-21', 'INV/SL-00047', 'Cash', NULL, '2024-06-21 17:07:59', '2024-06-21 17:07:59', NULL),
(56, 48, 'CS001', 75.00, '2024-06-21', 'INV/SL-00048', 'Mpesa', NULL, '2024-06-21 17:08:39', '2024-06-21 17:08:39', NULL),
(57, 49, 'CS001', 580.00, '2024-06-21', 'INV/SL-00049', 'Cash', NULL, '2024-06-21 17:15:06', '2024-06-21 17:15:06', NULL),
(58, 50, 'CS001', 65.00, '2024-06-21', 'INV/SL-00050', 'Mpesa', NULL, '2024-06-21 17:16:23', '2024-06-21 17:16:23', NULL),
(59, 51, 'CS001', 175.00, '2024-06-21', 'INV/SL-00051', 'Mpesa', NULL, '2024-06-21 17:17:32', '2024-06-21 17:17:32', NULL),
(60, 52, 'CS001', 225.00, '2024-06-21', 'INV/SL-00052', 'Cash', NULL, '2024-06-21 17:19:49', '2024-06-21 17:19:49', NULL),
(61, 53, 'CS001', 140.00, '2024-06-21', 'INV/SL-00053', 'Mpesa', NULL, '2024-06-21 17:20:38', '2024-06-21 17:20:38', NULL),
(62, 54, 'CS001', 20.00, '2024-06-21', 'INV/SL-00054', 'Cash', NULL, '2024-06-21 17:23:14', '2024-06-21 17:23:14', NULL),
(63, 55, 'CS001', 10.00, '2024-06-21', 'INV/SL-00055', 'Cash', NULL, '2024-06-21 17:34:05', '2024-06-21 17:34:05', NULL),
(64, 56, 'CS001', 140.00, '2024-06-21', 'INV/SL-00056', 'Cash', NULL, '2024-06-21 17:36:05', '2024-06-21 17:36:05', NULL),
(70, 62, 'CS001', 360.00, '2024-06-21', 'INV/SL-00062', 'Cash', NULL, '2024-06-21 17:38:09', '2024-06-21 17:38:09', NULL),
(72, 64, 'CS001', 100.00, '2024-06-21', 'INV/SL-00064', 'Mpesa', NULL, '2024-06-21 17:39:33', '2024-06-21 17:39:33', NULL),
(77, 69, 'CS001', 350.00, '2024-06-21', 'INV/SL-00069', 'Cash', NULL, '2024-06-21 17:44:27', '2024-06-21 17:44:27', NULL),
(92, 84, 'CS001', 20.00, '2024-06-22', 'INV/SL-00071', 'Cash', NULL, '2024-06-22 07:15:17', '2024-06-22 07:15:17', NULL),
(96, 88, 'CS001', 40.00, '2024-06-22', 'INV/SL-00088', 'Cash', NULL, '2024-06-22 07:21:14', '2024-06-22 07:21:14', NULL),
(97, 89, 'CS001', 335.00, '2024-06-22', 'INV/SL-00089', 'Cash', NULL, '2024-06-22 07:27:12', '2024-06-22 07:27:12', NULL),
(98, 92, 'CS001', 130.00, '2024-07-11', 'INV/SL-00090', 'Cash', NULL, '2024-07-11 05:16:16', '2024-07-11 05:16:16', NULL),
(99, 92, 'CS001', 25.00, '2024-07-11', 'INV/SL-00090', 'Mpesa', NULL, '2024-07-11 05:16:16', '2024-07-11 05:16:16', NULL),
(100, 93, 'CS001', 50.00, '2024-07-11', 'INV/SL-00093', 'Cash', NULL, '2024-07-11 05:27:06', '2024-07-11 05:27:06', NULL),
(101, 93, 'CS001', 40.00, '2024-07-11', 'INV/SL-00093', 'Mpesa', NULL, '2024-07-11 05:27:06', '2024-07-11 05:27:06', NULL),
(102, 94, 'CS001', 50.00, '2024-07-11', 'INV/SL-00094', 'Cash', NULL, '2024-07-11 05:27:36', '2024-07-11 05:27:36', NULL),
(103, 94, 'CS001', 40.00, '2024-07-11', 'INV/SL-00094', 'Mpesa', NULL, '2024-07-11 05:27:36', '2024-07-11 05:27:36', NULL),
(104, 95, 'CS001', 50.00, '2024-07-11', 'INV/SL-00095', 'Cash', NULL, '2024-07-11 05:28:47', '2024-07-11 05:28:47', NULL),
(105, 96, 'CS001', 50.00, '2024-07-11', 'INV/SL-00096', 'Cash', NULL, '2024-07-11 05:31:54', '2024-07-11 05:31:54', NULL),
(106, 97, 'CS001', 60.00, '2024-07-11', 'INV/SL-00097', 'Cash', NULL, '2024-07-11 05:42:23', '2024-07-11 05:42:23', NULL),
(107, 98, 'CS001', 60.00, '2024-07-11', 'INV/SL-00098', 'Cash', NULL, '2024-07-11 05:42:57', '2024-07-11 05:42:57', NULL),
(108, 99, 'CS001', 40.00, '2024-07-11', 'INV/SL-00099', 'Cash', NULL, '2024-07-11 05:43:34', '2024-07-11 05:43:34', NULL),
(109, 100, 'CS001', 40.00, '2024-07-11', 'INV/SL-00100', 'Cash', NULL, '2024-07-11 05:45:20', '2024-07-11 05:45:20', NULL),
(110, 101, 'CS001', 40.00, '2024-07-11', 'INV/SL-00101', 'Cash', NULL, '2024-07-11 05:51:48', '2024-07-11 05:51:48', NULL),
(111, 102, 'CS001', 20.00, '2024-07-11', 'INV/SL-00102', 'Cash', NULL, '2024-07-11 05:54:03', '2024-07-11 05:54:03', NULL),
(112, 103, 'CS001', 20.00, '2024-07-11', 'INV/SL-00103', 'Cash', NULL, '2024-07-11 05:54:12', '2024-07-11 05:54:12', NULL),
(113, 104, 'CS001', 20.00, '2024-07-11', 'INV/SL-00104', 'Cash', NULL, '2024-07-11 05:55:02', '2024-07-11 05:55:02', NULL),
(114, 105, 'CS001', 50.00, '2024-07-11', 'INV/SL-00105', 'Cash', NULL, '2024-07-11 05:55:28', '2024-07-11 05:55:28', NULL),
(115, 106, 'CS001', 10.00, '2024-07-11', 'INV/SL-00106', 'Cash', NULL, '2024-07-11 05:56:38', '2024-07-11 05:56:38', NULL),
(116, 107, 'CS001', 10.00, '2024-07-11', 'INV/SL-00107', 'Cash', NULL, '2024-07-11 05:56:45', '2024-07-11 05:56:45', NULL),
(117, 108, 'CS001', 40.00, '2024-07-11', 'INV/SL-00108', 'Cash', NULL, '2024-07-11 05:58:06', '2024-07-11 05:58:06', NULL),
(118, 109, 'CS001', 130.00, '2024-07-11', 'INV/SL-00109', 'Cash', NULL, '2024-07-11 05:59:16', '2024-07-11 05:59:16', NULL),
(119, 109, 'CS001', 25.00, '2024-07-11', 'INV/SL-00109', 'Mpesa', NULL, '2024-07-11 05:59:16', '2024-07-11 05:59:16', NULL),
(120, 110, 'CS001', 60.00, '2024-07-11', 'INV/SL-00110', 'Cash', NULL, '2024-07-11 06:01:08', '2024-07-11 06:01:08', NULL),
(121, 111, 'CS001', 60.00, '2024-07-11', 'INV/SL-00111', 'Cash', NULL, '2024-07-11 06:02:38', '2024-07-11 06:02:38', NULL),
(122, 112, 'CS001', 40.00, '2024-07-11', 'INV/SL-00112', 'Cash', NULL, '2024-07-11 06:03:20', '2024-07-11 06:03:20', NULL),
(123, 113, 'CS001', 50.00, '2024-07-11', 'INV/SL-00113', 'Cash', NULL, '2024-07-11 06:03:48', '2024-07-11 06:03:48', NULL),
(124, 114, 'CS001', 50.00, '2024-07-11', 'INV/SL-00114', 'Cash', NULL, '2024-07-11 06:04:18', '2024-07-11 06:04:18', NULL),
(125, 115, 'CS001', 60.00, '2024-07-11', 'INV/SL-00115', 'Cash', NULL, '2024-07-11 06:04:54', '2024-07-11 06:04:54', NULL),
(126, 116, 'CS001', 10.00, '2024-07-11', 'INV/SL-00116', 'Cash', NULL, '2024-07-11 06:05:32', '2024-07-11 06:05:32', NULL),
(127, 117, 'CS001', 40.00, '2024-07-11', 'INV/SL-00117', 'Cash', NULL, '2024-07-11 06:05:54', '2024-07-11 06:05:54', NULL),
(128, 118, 'CS001', 40.00, '2024-07-11', 'INV/SL-00118', 'Cash', NULL, '2024-07-11 06:06:19', '2024-07-11 06:06:19', NULL),
(129, 119, 'CS001', 40.00, '2024-07-11', 'INV/SL-00119', 'Cash', NULL, '2024-07-11 06:10:20', '2024-07-11 06:10:20', NULL),
(130, 120, 'CS001', 10.00, '2024-07-11', 'INV/SL-00120', 'Cash', NULL, '2024-07-11 06:14:18', '2024-07-11 06:14:18', NULL),
(131, 121, 'CS001', 10.00, '2024-07-11', 'INV/SL-00121', 'Cash', NULL, '2024-07-11 06:14:45', '2024-07-11 06:14:45', NULL),
(132, 122, 'CS001', 40.00, '2024-07-11', 'INV/SL-00122', 'Cash', NULL, '2024-07-11 06:17:43', '2024-07-11 06:17:43', NULL),
(133, 123, 'CS001', 40.00, '2024-07-11', 'INV/SL-00123', 'Cash', NULL, '2024-07-11 06:20:42', '2024-07-11 06:20:42', NULL),
(134, 124, 'CS001', 50.00, '2024-07-11', 'INV/SL-00124', 'Cash', NULL, '2024-07-11 06:21:16', '2024-07-11 06:21:16', NULL),
(135, 125, 'CS001', 10.00, '2024-07-11', 'INV/SL-00125', 'Cash', NULL, '2024-07-11 06:21:46', '2024-07-11 06:21:46', NULL),
(136, 126, 'CS001', 10.00, '2024-07-11', 'INV/SL-00126', 'Cash', NULL, '2024-07-11 06:29:59', '2024-07-11 06:29:59', NULL),
(137, 127, 'CS001', 10.00, '2024-07-11', 'INV/SL-00127', 'Cash', NULL, '2024-07-11 06:30:40', '2024-07-11 06:30:40', NULL),
(138, 128, 'CS001', 40.00, '2024-07-11', 'INV/SL-00128', 'Cash', NULL, '2024-07-11 06:31:51', '2024-07-11 06:31:51', NULL),
(139, 129, 'CS001', 40.00, '2024-07-11', 'INV/SL-00129', 'Cash', NULL, '2024-07-11 06:34:04', '2024-07-11 06:34:04', NULL),
(140, 130, 'CS001', 10.00, '2024-07-11', 'INV/SL-00130', 'Cash', NULL, '2024-07-11 06:37:47', '2024-07-11 06:37:47', NULL),
(141, 131, 'CS001', 10.00, '2024-07-11', 'INV/SL-00131', 'Cash', NULL, '2024-07-11 07:46:32', '2024-07-11 07:46:32', NULL),
(142, 132, 'CS001', 10.00, '2024-07-11', 'INV/SL-00132', 'Cash', NULL, '2024-07-11 08:04:11', '2024-07-11 08:04:11', NULL),
(143, 133, 'CS001', 10.00, '2024-07-11', 'INV/SL-00133', 'Cash', NULL, '2024-07-11 08:04:48', '2024-07-11 08:04:48', NULL),
(144, 134, 'CS001', 50.00, '2024-07-11', 'INV/SL-00134', 'Cash', NULL, '2024-07-11 08:05:09', '2024-07-11 08:05:09', NULL),
(145, 135, 'CS001', 40.00, '2024-07-11', 'INV/SL-00135', 'Cash', NULL, '2024-07-11 08:34:44', '2024-07-11 08:34:44', NULL),
(146, 136, 'CS001', 40.00, '2024-07-11', 'INV/SL-00136', 'Cash', NULL, '2024-07-11 08:36:33', '2024-07-11 08:36:33', NULL),
(147, 136, 'CS001', 10.00, '2024-07-11', 'INV/SL-00136', 'Mpesa', NULL, '2024-07-11 08:36:33', '2024-07-11 08:36:33', NULL),
(148, 137, 'CS001', 40.00, '2024-07-12', 'INV/SL-00137', 'Cash', NULL, '2024-07-12 16:14:58', '2024-07-12 16:14:58', NULL),
(149, 137, 'CS001', 10.00, '2024-07-12', 'INV/SL-00137', 'Cash', NULL, '2024-07-12 16:14:58', '2024-07-12 16:14:58', NULL),
(150, 138, 'CS001', 23.00, '2024-07-12', 'INV/SL-00138', 'Cash', NULL, '2024-07-12 17:29:17', '2024-07-12 17:29:17', NULL),
(151, 140, 'CS001', 60.00, '2024-10-19', 'INV/SL-00140', 'Cash', NULL, '2024-10-19 02:55:55', '2024-10-19 02:55:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sale_returns`
--

CREATE TABLE `sale_returns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `reference` varchar(255) NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_name` varchar(255) NOT NULL,
  `tax_percentage` int(11) NOT NULL DEFAULT 0,
  `tax_amount` int(11) NOT NULL DEFAULT 0,
  `discount_percentage` int(11) NOT NULL DEFAULT 0,
  `discount_amount` int(11) NOT NULL DEFAULT 0,
  `shipping_amount` int(11) NOT NULL DEFAULT 0,
  `total_amount` int(11) NOT NULL,
  `paid_amount` int(11) NOT NULL,
  `due_amount` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale_return_details`
--

CREATE TABLE `sale_return_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_return_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `unit_price` int(11) NOT NULL,
  `sub_total` int(11) NOT NULL,
  `product_discount_amount` int(11) NOT NULL,
  `product_discount_type` varchar(255) NOT NULL DEFAULT 'fixed',
  `product_tax_amount` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale_return_payments`
--

CREATE TABLE `sale_return_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_return_id` bigint(20) UNSIGNED NOT NULL,
  `amount` int(11) NOT NULL,
  `date` date NOT NULL,
  `reference` varchar(255) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('0M2joL1eK1DOaIa1dZ4pQ7I8kv5DcvBMbQlhxe8g', NULL, '34.69.75.24', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1467.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQmYwMDBUbFpuRm5WWFA5NU5TeVpSU2NMaXN4TVB2SDMyUGJEU0I5aSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718524462),
('2tMcoBEb6VkwPWIMcdAegC0p6EMkuR07QIF3bghy', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMTRFVEFOS0dqSXBMTEg5ZFE3c2ZFM1Qwb1phTW1KNlZ4RDRGblAydyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoxNjoiaHR0cDovL2xvY2FsaG9zdCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjE2OiJodHRwOi8vbG9jYWxob3N0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718910353),
('3F2EuC5cx2YsTSV6SHrUHUonr5b2h10prPzSCXRX', NULL, '162.142.125.204', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoieDh6cnFmdWdiWVNhZlZKclBXeG5EbXpyNks1MllGVUZzMExMQVltZSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718555595),
('6yOQF5SPaqPEbF8yKKIFSUAVyjN8i2iEYkvlz6ap', NULL, '5.164.29.116', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36 (scanner.ducks.party)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTUluaDRSbkc3N3JlU2JBdTJKQm9mZWNSalhXNDNlWnJKem1sb2ZObSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718570483),
('6ZFzW75zcBhcurZFdzMn0nEGq3EAW2ZUBsZQNwSh', 1, '102.219.208.41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0', 'YTo4OntzOjY6Il90b2tlbiI7czo0MDoiSklSeUhIWHRSbG9BNHk5dE9JSGtyNzR6aUdqbERBcFdRZXJoVDNxMCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM2OiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlL2hvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6NDoiYXV0aCI7YToxOntzOjIxOiJwYXNzd29yZF9jb25maXJtZWRfYXQiO2k6MTcxODUzOTAzNjt9czo0OiJjYXJ0IjthOjA6e31zOjU6ImFsZXJ0IjthOjA6e319', 1718611003),
('81Z8y0cGpYzizviIUmh8AyQwaF4RIjcZTAJyQ93x', NULL, '5.164.29.116', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36 (scanner.ducks.party)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidUM2UTFYamtNa2lSTlZVMnh2ZlNydmhHWUF6cjkyN2FtN3NhZ256UCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718526535),
('aJHpLGeICvEMfyXg7Sc4wSuDGXETDeZsUBDaCOzj', NULL, '142.93.206.118', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOFhCc0VjVnJ1dHlkbTQ0N241UFBwZEw0dVZHNWdNOGl0OE04Vmp1bSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9tZXJlbWFydC5tYXN0ZXJwb3MuY28ua2UvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1718563316),
('baPaXi3gAZHnfACgKOVpX6TNY8qPMlvChX54fZIK', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiSWppTnlSTFBPWk80bGk1S2Q3Ulp0Wm95QVF2U2FWbHplWVFrcDdMYiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vbWVyZW1hcnQucG9zL2FwcC9wb3MiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6NDoiYXV0aCI7YToxOntzOjIxOiJwYXNzd29yZF9jb25maXJtZWRfYXQiO2k6MTcxODg5OTcwMDt9fQ==', 1718899740),
('cGuYTRFBiJDJKuRunwdbDx4NvabOxoPODoZ73bK9', 9, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiQmtac0lHek92d0hxQzNNWVQ2bnZkUDVpQ3hTZ21rcjBneHJ2UmNsbyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI1OiJodHRwOi8vbWVyZW1hcnQucG9zL2xvZ2luIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6OTtzOjQ6ImF1dGgiO2E6MTp7czoyMToicGFzc3dvcmRfY29uZmlybWVkX2F0IjtpOjE3MTg5MTA0MTg7fX0=', 1718910418),
('CzaJYN4WwWdtbyrwigwzeVR0fNkpVj5wf1p7t5kI', 8, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTo4OntzOjY6Il90b2tlbiI7czo0MDoiVGRtU0JaakI0T3I1bm5RaXg1d21EYllEeFM2aUdiVE04Q3FHNUhCbiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMyOiJodHRwOi8vbWVyZW1hcnQucG9zL3NhbGVzLXJlcG9ydCI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjg7czo0OiJhdXRoIjthOjE6e3M6MjE6InBhc3N3b3JkX2NvbmZpcm1lZF9hdCI7aToxNzE4OTkwNzU2O31zOjQ6ImNhcnQiO2E6MDp7fXM6NToiYWxlcnQiO2E6MDp7fX0=', 1718993528),
('DcIBpbLfeG5T0AKJWGLuKTUmfp1gGSXcvWzF3Fcy', NULL, '34.248.137.227', 'Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101 Firefox/83.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidU16SjNIaDYyYmIxb0ZzV0tvaUhnRmRJTWtqajJ2YVEzSWU1Mm5QWCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM3OiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718531549),
('DoKsRhLwBZenTgLEwxzdQUTSqZphGAgfZnzpIhJ8', 1, '154.159.231.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:127.0) Gecko/20100101 Firefox/127.0', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoieElFeUc2alFzUlhJN1NicDM0SzBPQmxLdzRlVEtmUERmWENsTEtSWCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQwOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlL3Byb2R1Y3RzIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjQ6ImF1dGgiO2E6MTp7czoyMToicGFzc3dvcmRfY29uZmlybWVkX2F0IjtpOjE3MTg2MTEyNTI7fX0=', 1718611270),
('hNM83VVQ01WbhgOLV8R67VeiU6v07GCn4s6ZK5Ix', NULL, '65.154.226.169', 'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWUdwMXV6OHBEWFpKVHlnRDBIQnlnVmZBb2VvMXhKSnAyTGJYZmtTTCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718524381),
('iEnTmbgyNe19dp5oPUVZGzfWG9bPudVmdrEG9oki', NULL, '34.123.170.104', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/92.0.4515.159 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiOU96eGl1Nml1Mkx3a1VqV1pCQUF0NFFySEdWQmFQVXdkUEo1a1hTTSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718524374),
('jh3O9mgYTEf1aafOVdWZkHZ3i8h1TnasnHpCychS', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTo4OntzOjY6Il90b2tlbiI7czo0MDoiRFZrbVBHb0IyRTFBUGRPTFJubDgxeXJPeTVqTHlBWHpyRldCbVRyZCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI4OiJodHRwOi8vbWVyZW1hcnQudGVzdC9hcHAvcG9zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjQ6ImF1dGgiO2E6MTp7czoyMToicGFzc3dvcmRfY29uZmlybWVkX2F0IjtpOjE3MTkwMzg3OTg7fXM6NDoiY2FydCI7YTowOnt9czo1OiJhbGVydCI7YTowOnt9fQ==', 1721982380),
('K7asduS0BTwLf3rY6L4LBwwnsUo3v7zf7eHPhG7W', NULL, '162.142.125.204', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNU1rbXZlQVgzUjRuSFFXeW9KRVZuRmtqQjVETlc3SExrNGk0T0IzMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9tZXJlbWFydC5tYXN0ZXJwb3MuY28ua2UvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1718555602),
('L0hj5eOmHClXkn0UFBupNIjH1KiqQiwKSD5SwFW3', NULL, '64.15.129.101', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibnRTZzR5aTU0WGNkM3kwekdXd1VBUTF5VmVGY2ZHWnViSDk5cUtZciI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718527692),
('L0SGkBvAgYcR3tGvY8Tl5WmGSpkChSggvy0Iq3gg', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTo4OntzOjY6Il90b2tlbiI7czo0MDoiOGw5cmFQQXlnalRnU25YZ0V2MHBkdEUweEJXWndZUUtaS1VWN2hPNCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI4OiJodHRwOi8vbWVyZW1hcnQudGVzdC9hcHAvcG9zIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjQ6ImF1dGgiO2E6MTp7czoyMToicGFzc3dvcmRfY29uZmlybWVkX2F0IjtpOjE3MjkzMDY1MjA7fXM6NDoiY2FydCI7YTowOnt9czo1OiJhbGVydCI7YTowOnt9fQ==', 1729306559),
('Lk8u31RtVVBTHjGxy4ZSDddXRMq4q3Hs1EPXURyh', NULL, '65.154.226.169', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUlE1Zk9sRFgzbkRheUpnUDkyT2FlaU42anhxMnNxNll5WjJRbEhsRiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718524373),
('m4YcdIAoNwY7tmOfGZ8rJ108zogzEEu8HfBRfqSb', NULL, '64.15.129.107', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNlFoSE9NSDhvbWU1MjJpVHBGS21yMnpkWGExOVFVV05xTU9TS0xtMSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718527696),
('nhPMKH8GcCaskREsld7LAxIm1vYBygvIfTFPjVzH', NULL, '142.93.206.118', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZ2szOXhVc0NpdFdrM2V4ZzdQQmxNUVF5Q2NmcGJkU3loTjROQUNKOCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718563316),
('NWQanD22hs3S1K3DKgMDaLRFNREfUASJHtOmK0UU', NULL, '102.219.208.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:127.0) Gecko/20100101 Firefox/127.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUWVnYkNkUFlJcm1yVDBzYXRFQlBZa013dEoxeW5BUFZjVUVEODJIdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9tZXJlbWFydC5tYXN0ZXJwb3MuY28ua2UvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1718543112),
('OeKn842qttDJzRfgawjCxteweErkbQpynxoP80ro', NULL, '134.122.28.88', '', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMndZY002WU5ITGFOTGg2YUlBTHNLaWhsQ3J6c2xBSjlPTTd3bXFiMCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718524310),
('RyvUMdatBIrTX3AEr9JRQ62rMjK1tYxmKqu777tu', NULL, '192.175.111.231', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicUxwQlZncXliT0QxeHJ1OEJpa0hCTnR5QVBZREpvWE10bjFJd1Q5QiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718527693),
('SfaTrKyWkvViq0PDp5Bv6hCGVlVEEDOI5g9wX2fQ', NULL, '102.219.208.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:127.0) Gecko/20100101 Firefox/127.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTVVIOEtESmxId3REdjA2cWNGOVNLZmlldmNQdk4xckVlQmxCM21zNyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MDoiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZS9wcm9kdWN0cyI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQwOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlL3Byb2R1Y3RzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718543112),
('svkyGobKitGSiRUg7QaTrOk8WSefpgWBcctjvhgg', NULL, '192.175.111.252', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaW5RcndUcEl2ZjB6ZFY0VW1QUTJhamNxc2R4alNuSHdYUXY1dVlhTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9tZXJlbWFydC5tYXN0ZXJwb3MuY28ua2UvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1718527696),
('tq5arlGDGqYu6pkQgG4UprEmnOp6hbikTe8FbP6j', 1, '102.219.208.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:127.0) Gecko/20100101 Firefox/127.0', 'YTo4OntzOjY6Il90b2tlbiI7czo0MDoiQThGSjhTNDh1YUI5UlZNM2twZ1hQbFFoTUQ1NFRicVpvZlFxazR4aSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQ3OiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlL3Byb2R1Y3RzL2NyZWF0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czo0OiJhdXRoIjthOjE6e3M6MjE6InBhc3N3b3JkX2NvbmZpcm1lZF9hdCI7aToxNzE4NTI2OTI2O31zOjQ6ImNhcnQiO2E6MTp7czo0OiJzYWxlIjtPOjI5OiJJbGx1bWluYXRlXFN1cHBvcnRcQ29sbGVjdGlvbiI6Mjp7czo4OiIAKgBpdGVtcyI7YTowOnt9czoyODoiACoAZXNjYXBlV2hlbkNhc3RpbmdUb1N0cmluZyI7YjowO319czo1OiJhbGVydCI7YTowOnt9fQ==', 1718532099),
('tUdr3rLm646XTQbarHG9sOC7FzBG8h2cZe5Gn5xj', NULL, '205.169.39.243', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQzFmb1ZyMjNvVml0bFhvUThZc1R5Y2xIYXRIVE9JeExQR1ZWUnpPbyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718524389),
('uDOF515NXSWryJ6Y8YtaaZMVy016dKxCa9fDoFFk', NULL, '64.15.129.107', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS2lMZ1czRTdmQzI4a2VIZGVDZ1lIWEVlcjlZa3E3U3lDbGdCTFZFSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9tZXJlbWFydC5tYXN0ZXJwb3MuY28ua2UvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1718527697),
('vJt5S9qpcv0vRF225uqWxOKIFROhgDWbzgYKEhAD', NULL, '192.175.111.252', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVG82ZTVZdnU1UTNnQlM1VnFBcnlXOEVvcGxIU1lQcTBjbTdZb1QxcCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718527696),
('VUDZWOdTdPtdKqAsPxLwRjOmyVqxxIloFzXRUJmS', NULL, '134.122.28.88', 'Go-http-client/1.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWVNXMjVQOEtONTdXRlRnVEUyZTV2cDdyUXpDWHM4ZnNWSzlxUERadSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo2NToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZS8/cmVzdF9yb3V0ZT0lMkZ3cCUyRnYyJTJGdXNlcnMlMkYiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czo2NToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZS8/cmVzdF9yb3V0ZT0lMkZ3cCUyRnYyJTJGdXNlcnMlMkYiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1718524316),
('Vv0dEg481BRYrHyBpyAltoW2sxdPgTF8imy41Obp', 1, '102.135.174.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiNFhMUU9hMnFuT0MwaGMzdW9aWXc5MlRlYXZRZktRcUNydFFweXdZbSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQ3OiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlL3Byb2R1Y3RzL2NyZWF0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czo0OiJhdXRoIjthOjE6e3M6MjE6InBhc3N3b3JkX2NvbmZpcm1lZF9hdCI7aToxNzE4NTI1OTAyO31zOjU6ImFsZXJ0IjthOjA6e319', 1718532313),
('xwtlZ1I7sUR3CBgkMuapumjGhLvMMbb0oLuuoDmS', NULL, '134.122.28.88', 'Mozilla/5.0 (Linux; Android 6.0; HTC One M9 Build/MRA428969) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2990.98 Mobile Safari/537.3', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicW1GSFpiWEJRMzVqUjh5Q3FuNm9EZ1k3N2JCc21pUXZpNWtDQXBhciI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL21lcmVtYXJ0Lm1hc3RlcnBvcy5jby5rZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vbWVyZW1hcnQubWFzdGVycG9zLmNvLmtlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718524310),
('Yf33xEaeSZ4x6l0qfhoUUjv38iv21nLtXWm2c2HS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoidzB3NXJRS01uQW1qTlI5MXIxUHZrcU5kcVpWTVZwd3FlZzE1SzhRcSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1718707624),
('yqG6X591xiRKOdbF87julC6U8RPW7hJszezx6um1', NULL, '192.175.111.231', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSGttbXBlakpkTUtjaGc5S3U1MzcwNDZSQUtqZkwxNGRkaGdaVFo3SSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9tZXJlbWFydC5tYXN0ZXJwb3MuY28ua2UvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1718527693),
('ZG7VYH3Wc4ope5tkwv6iUNjlqZPqrcENdayCN89r', NULL, '64.15.129.101', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZGhRRWJOTHBqeDlvQmk3d0tUZ0tnaUVrN0o3Y2Q3QUV2b3lqV3g2WCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9tZXJlbWFydC5tYXN0ZXJwb3MuY28ua2UvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1718527692);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `company_email` varchar(255) NOT NULL,
  `company_phone` varchar(255) NOT NULL,
  `site_logo` varchar(255) DEFAULT NULL,
  `default_currency_id` int(11) NOT NULL,
  `default_currency_position` varchar(255) NOT NULL,
  `notification_email` varchar(255) NOT NULL,
  `footer_text` text NOT NULL,
  `payment_terms` text DEFAULT NULL,
  `recept_text` text DEFAULT NULL,
  `additional_text` text DEFAULT NULL,
  `company_address` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `company_name`, `company_email`, `company_phone`, `site_logo`, `default_currency_id`, `default_currency_position`, `notification_email`, `footer_text`, `payment_terms`, `recept_text`, `additional_text`, `company_address`, `created_at`, `updated_at`) VALUES
(1, 'MERE MART MINIMART', 'meremart@gmail.com', '254', NULL, 1, 'prefix', 'meremart@gmail.com', 'POS MASTER © 2023 || Developed by <strong><a target=\"_blank\" href=\"https://hillsdatatechnologies.co.ke/\">HillsData Technologies</a></strong>', NULL, 'Glad to be at your service. Welcome Again!!', 'Dealers in General Hardware & Building/Construction Materials', 'Nairobi, Kenya', '2023-02-04 17:44:34', '2024-06-16 12:03:02');

-- --------------------------------------------------------

--
-- Table structure for table `stocksheets`
--

CREATE TABLE `stocksheets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference` varchar(255) NOT NULL,
  `product_id` int(11) NOT NULL,
  `system_qty` int(11) NOT NULL,
  `actual_qty` int(11) NOT NULL,
  `uuid` char(36) DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT 0,
  `is_current` tinyint(1) NOT NULL DEFAULT 0,
  `publisher_type` varchar(255) DEFAULT NULL,
  `publisher_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `supplier_name` varchar(255) DEFAULT NULL,
  `supplier_email` varchar(255) DEFAULT NULL,
  `supplier_phone` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `supplier_code` varchar(191) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `supplier_name`, `supplier_email`, `supplier_phone`, `city`, `country`, `supplier_code`, `address`, `created_at`, `updated_at`) VALUES
(1, 'Supplier', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'SUIPPLIER', NULL, NULL, NULL, NULL, NULL, NULL, '2024-06-16 11:38:19', '2024-06-16 11:38:19');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction` text DEFAULT NULL,
  `TransactionType` varchar(191) DEFAULT NULL,
  `TransID` varchar(191) DEFAULT NULL,
  `TransTime` datetime DEFAULT NULL,
  `TransAmount` decimal(8,2) DEFAULT NULL,
  `BusinessShortCode` varchar(191) DEFAULT NULL,
  `BillRefNumber` varchar(191) DEFAULT NULL,
  `InvoiceNumber` varchar(191) DEFAULT NULL,
  `OrgAccountBalance` varchar(191) DEFAULT NULL,
  `ThirdPartyTransID` varchar(191) DEFAULT NULL,
  `MSISDN` varchar(191) DEFAULT NULL,
  `FirstName` varchar(191) DEFAULT NULL,
  `MiddleName` varchar(191) DEFAULT NULL,
  `LastName` varchar(191) DEFAULT NULL,
  `code_used` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference` varchar(255) NOT NULL,
  `location_from` int(11) NOT NULL,
  `location_to` int(11) NOT NULL,
  `received` int(11) NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uploads`
--

CREATE TABLE `uploads` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `folder` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `is_active`, `branch_id`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'MERE MART', 'meremart@gmail.com', NULL, '$2y$10$ShUzTGeEGPSYAbcAr2FeDetrlJ6c4OlFcFdM76eip38vMNNjsucsO', 1, 1, NULL, '2023-02-04 17:44:34', '2024-06-16 13:06:49'),
(6, 'Nelson', 'nk.nelsonkamau99@gmail.com', NULL, '$2y$10$pCcUVhTJDGsRI..6bFxOVuohfzNYswO406Q.JheAIiLY5AjC.ZJh2', 1, 1, NULL, '2024-06-18 03:15:50', '2024-06-18 03:15:50'),
(7, 'TABITHA', 'TABBY@gmail.com', NULL, '$2y$10$oosOQfCfCCk1VBEh0l3N9O7xk6MRcimSZ4fQ6lv5PmQ1HEavjR0F6', 1, 1, NULL, '2024-06-18 03:18:09', '2024-06-18 03:18:09'),
(8, 'murage', 'murage@gmail.com', NULL, '$2y$10$yYciQ6LhDA6fF02wG0y7QuASw6FhaKG1pdJ1cvjUPmzguRYLU/R92', 1, 1, NULL, '2024-06-18 03:39:13', '2024-06-18 03:39:13'),
(9, 'Margaret', 'margaret@gmail.com', NULL, '$2y$10$E56qKuRu3bQATD7j/EvTl.A/dI2N26lwQWmAVDmgG0P436Nykvh62', 1, 1, NULL, '2024-06-20 16:52:35', '2024-06-20 16:52:35'),
(10, 'Judith', 'judith@gmail.com', NULL, '$2y$10$TsZeE0PVT0YolrPz8TaBo.ReH1kff8hLXTn3gO2qDGU5zYXIsEPYm', 1, 1, NULL, '2024-06-21 00:04:48', '2024-06-21 00:04:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adjusted_products`
--
ALTER TABLE `adjusted_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adjusted_products_adjustment_id_foreign` (`adjustment_id`);

--
-- Indexes for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_category_code_unique` (`category_code`);

--
-- Indexes for table `close_days`
--
ALTER TABLE `close_days`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dailymails`
--
ALTER TABLE `dailymails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expenses_category_id_foreign` (`category_id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_payments`
--
ALTER TABLE `invoice_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `lpos`
--
ALTER TABLE `lpos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lpos_supplier_id_foreign` (`supplier_id`);

--
-- Indexes for table `lpo_details`
--
ALTER TABLE `lpo_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lpo_details_lpo_id_foreign` (`lpo_id`),
  ADD KEY `lpo_details_product_id_foreign` (`product_id`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_uuid_unique` (`uuid`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_product_code_unique` (`product_code`),
  ADD KEY `products_category_id_foreign` (`category_id`);

--
-- Indexes for table `product_branches`
--
ALTER TABLE `product_branches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_branches_product_id_foreign` (`product_id`),
  ADD KEY `product_branches_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `product_transfers`
--
ALTER TABLE `product_transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchases_location_id_foreign` (`location_id`),
  ADD KEY `purchases_supplier_id_foreign` (`supplier_id`);

--
-- Indexes for table `purchase_bulk_payments`
--
ALTER TABLE `purchase_bulk_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_bulk_payments_user_id_foreign` (`user_id`),
  ADD KEY `purchase_bulk_payments_supplier_id_foreign` (`supplier_id`);

--
-- Indexes for table `purchase_details`
--
ALTER TABLE `purchase_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_details_purchase_id_foreign` (`purchase_id`),
  ADD KEY `purchase_details_product_id_foreign` (`product_id`);

--
-- Indexes for table `purchase_payments`
--
ALTER TABLE `purchase_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_payments_purchase_id_foreign` (`purchase_id`);

--
-- Indexes for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_returns_supplier_id_foreign` (`supplier_id`);

--
-- Indexes for table `purchase_return_details`
--
ALTER TABLE `purchase_return_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_return_details_purchase_return_id_foreign` (`purchase_return_id`),
  ADD KEY `purchase_return_details_product_id_foreign` (`product_id`);

--
-- Indexes for table `purchase_return_payments`
--
ALTER TABLE `purchase_return_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_return_payments_purchase_return_id_foreign` (`purchase_return_id`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quotations_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `quotation_details`
--
ALTER TABLE `quotation_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quotation_details_quotation_id_foreign` (`quotation_id`),
  ADD KEY `quotation_details_product_id_foreign` (`product_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_customer_id_foreign` (`customer_id`),
  ADD KEY `sales_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `sale_bulk_payments`
--
ALTER TABLE `sale_bulk_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_bulk_payments_user_id_foreign` (`user_id`),
  ADD KEY `sale_bulk_payments_client_id_foreign` (`client_id`);

--
-- Indexes for table `sale_details`
--
ALTER TABLE `sale_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_details_sale_id_foreign` (`sale_id`),
  ADD KEY `sale_details_product_id_foreign` (`product_id`);

--
-- Indexes for table `sale_payments`
--
ALTER TABLE `sale_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_payments_sale_id_foreign` (`sale_id`);

--
-- Indexes for table `sale_returns`
--
ALTER TABLE `sale_returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_returns_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `sale_return_details`
--
ALTER TABLE `sale_return_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_return_details_sale_return_id_foreign` (`sale_return_id`),
  ADD KEY `sale_return_details_product_id_foreign` (`product_id`);

--
-- Indexes for table `sale_return_payments`
--
ALTER TABLE `sale_return_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_return_payments_sale_return_id_foreign` (`sale_return_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stocksheets`
--
ALTER TABLE `stocksheets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stocksheets_publisher_type_publisher_id_index` (`publisher_type`,`publisher_id`),
  ADD KEY `stocksheets_uuid_is_published_is_current_index` (`uuid`,`is_published`,`is_current`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uploads`
--
ALTER TABLE `uploads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adjusted_products`
--
ALTER TABLE `adjusted_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `close_days`
--
ALTER TABLE `close_days`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dailymails`
--
ALTER TABLE `dailymails`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_payments`
--
ALTER TABLE `invoice_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lpos`
--
ALTER TABLE `lpos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lpo_details`
--
ALTER TABLE `lpo_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1895;

--
-- AUTO_INCREMENT for table `product_branches`
--
ALTER TABLE `product_branches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT for table `product_transfers`
--
ALTER TABLE `product_transfers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_bulk_payments`
--
ALTER TABLE `purchase_bulk_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_details`
--
ALTER TABLE `purchase_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_payments`
--
ALTER TABLE `purchase_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_return_details`
--
ALTER TABLE `purchase_return_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_return_payments`
--
ALTER TABLE `purchase_return_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotation_details`
--
ALTER TABLE `quotation_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table `sale_bulk_payments`
--
ALTER TABLE `sale_bulk_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale_details`
--
ALTER TABLE `sale_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=172;

--
-- AUTO_INCREMENT for table `sale_payments`
--
ALTER TABLE `sale_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- AUTO_INCREMENT for table `sale_returns`
--
ALTER TABLE `sale_returns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale_return_details`
--
ALTER TABLE `sale_return_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale_return_payments`
--
ALTER TABLE `sale_return_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `stocksheets`
--
ALTER TABLE `stocksheets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uploads`
--
ALTER TABLE `uploads`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `adjusted_products`
--
ALTER TABLE `adjusted_products`
  ADD CONSTRAINT `adjusted_products_adjustment_id_foreign` FOREIGN KEY (`adjustment_id`) REFERENCES `adjustments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `expense_categories` (`id`);

--
-- Constraints for table `lpos`
--
ALTER TABLE `lpos`
  ADD CONSTRAINT `lpos_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `lpo_details`
--
ALTER TABLE `lpo_details`
  ADD CONSTRAINT `lpo_details_lpo_id_foreign` FOREIGN KEY (`lpo_id`) REFERENCES `lpos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lpo_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `product_branches`
--
ALTER TABLE `product_branches`
  ADD CONSTRAINT `product_branches_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_branches_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `purchases_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `purchase_bulk_payments`
--
ALTER TABLE `purchase_bulk_payments`
  ADD CONSTRAINT `purchase_bulk_payments_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_bulk_payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_details`
--
ALTER TABLE `purchase_details`
  ADD CONSTRAINT `purchase_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `purchase_details_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_payments`
--
ALTER TABLE `purchase_payments`
  ADD CONSTRAINT `purchase_payments_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD CONSTRAINT `purchase_returns_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `purchase_return_details`
--
ALTER TABLE `purchase_return_details`
  ADD CONSTRAINT `purchase_return_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `purchase_return_details_purchase_return_id_foreign` FOREIGN KEY (`purchase_return_id`) REFERENCES `purchase_returns` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_return_payments`
--
ALTER TABLE `purchase_return_payments`
  ADD CONSTRAINT `purchase_return_payments_purchase_return_id_foreign` FOREIGN KEY (`purchase_return_id`) REFERENCES `purchase_returns` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quotations`
--
ALTER TABLE `quotations`
  ADD CONSTRAINT `quotations_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `quotation_details`
--
ALTER TABLE `quotation_details`
  ADD CONSTRAINT `quotation_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `quotation_details_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sales_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sale_bulk_payments`
--
ALTER TABLE `sale_bulk_payments`
  ADD CONSTRAINT `sale_bulk_payments_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sale_bulk_payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sale_details`
--
ALTER TABLE `sale_details`
  ADD CONSTRAINT `sale_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sale_details_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sale_payments`
--
ALTER TABLE `sale_payments`
  ADD CONSTRAINT `sale_payments_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sale_returns`
--
ALTER TABLE `sale_returns`
  ADD CONSTRAINT `sale_returns_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sale_return_details`
--
ALTER TABLE `sale_return_details`
  ADD CONSTRAINT `sale_return_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sale_return_details_sale_return_id_foreign` FOREIGN KEY (`sale_return_id`) REFERENCES `sale_returns` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sale_return_payments`
--
ALTER TABLE `sale_return_payments`
  ADD CONSTRAINT `sale_return_payments_sale_return_id_foreign` FOREIGN KEY (`sale_return_id`) REFERENCES `sale_returns` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
