/*
 * VarArgs.h -- Portable variable-argument list declarations
 *
 * Portions copyright American Telephone & Telegraph
 * Used with permission, Apple Computer Inc. (1985, 1986)
 * All rights reserved.
 */

typedef char *va_list;
#define va_dcl int va_alist;
#define va_start(list) list = (char *) &va_alist
#define va_end(list)
#define va_arg(list, mode) ((mode *)(list += sizeof(mode)))[-1]
