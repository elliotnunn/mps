/*
 *  typeinfo.h
 *
 *  Copyright (c) 1995 Symantec Corporation.  All rights reserved.
 *
 *  $Header: /standard libs/headers and src/C++ Headers/typeinfo.h 2     9/13/95 1:56p Jmicco $
 *
 */
 
#if __SC__ || __RCC__
#pragma once
#endif

#ifndef __TYPEINFO_H
#define __TYPEINFO_H 1

#ifndef __cplusplus
#error	Use C++ compiler for typeinfo.h
#endif

extern "C++" {

#if defined(__MRC__)  &&  __MRC__ >= 0x200
	class type_info
	{
		public:
		void *pdata;
	
		private:
		__cdecl type_info(const type_info&);
		type_info& __cdecl operator=(const type_info&);
	
		public:
		virtual __cdecl ~type_info();
	
		int __cdecl operator==(const type_info&) const;
		int __cdecl operator!=(const type_info&) const;
		int __cdecl before(const type_info&);
		const char * __cdecl name() const;
	};
#else
	class Type_info
	{
		public:
		void *pdata;
	
		private:
		__cdecl Type_info(const Type_info&);
		Type_info& __cdecl operator=(const Type_info&);
	
		public:
		virtual __cdecl ~Type_info();
	
		int __cdecl operator==(const Type_info&) const;
		int __cdecl operator!=(const Type_info&) const;
		int __cdecl before(const Type_info&);
		const char * __cdecl name() const;
	};
#endif
};

class Bad_cast { };

#endif
