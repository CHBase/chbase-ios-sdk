//
//  HealthVaultConfig.h
//  CHBase Mobile Library for iOS
//
//


#ifndef __OPTIMIZE__

	/// If TRUE then the library traces all requests, responses and other debug information to a console. 
	#define HEALTH_VAULT_TRACE_ENABLED 0

#else

	#define HEALTH_VAULT_TRACE_ENABLED 0

#endif

/// default HealthVault platform URL
#define HEALTH_VAULT_PLATFORM_URL @"https://platform.healthvault-ppe.com/platform/wildcat.ashx"

/// default HealthVault shell URL
#define HEALTH_VAULT_SHELL_URL @"https://account.healthvault-ppe.com" 

/// default language identifier
#define DEFAULT_LANGUAGE @"en"

/// default country code identifier
#define DEFAULT_COUNTRY @"US"