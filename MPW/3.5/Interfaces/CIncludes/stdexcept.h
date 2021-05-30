//
//	<stdexcept> header
//		This header is defined as in clause 19 of the
//		current (January 1996) C++ working papers.
//		However, the C++ library shipped with this version
//		of MrCpp does *not* throw any of these exceptions.
//		This file is present as a placeholder and so that
//		users may start using the standard exceptions
//		hierarchy.
//
//		Copyright 1996, Apple Computer, Inc.
//

#ifndef __STDEXCEPT_H
#define __STDEXCEPT_H 1


#include <exception.h>
/* We do not yet have a std <string> header... */
class string;

//
// Once <exception> is in place, this place-holder
// definition of "class exception" will be removed.
//
class exception {
 public:
      exception() throw() {}
      exception(const exception&) throw() {}
      exception& operator=(const exception&) throw() {}
      virtual ~exception() throw() {}
      virtual const char* what() const throw() {}
};

//  namespace std {

    class logic_error : public exception {
    public:
      logic_error(const string& what_arg);
    };

    class domain_error : public logic_error {
    public:
      domain_error(const string& what_arg);
    };

    class invalid_argument : public logic_error {
    public:
      invalid_argument(const string& what_arg);
    };

    class length_error : public logic_error {
    public:
      length_error(const string& what_arg);
    };

    class out_of_range : public logic_error {
    public:
      out_of_range(const string& what_arg);
    };

    class runtime_error : public exception {
    public:
      runtime_error(const string& what_arg);
    };

    class range_error : public runtime_error {
    public:
      range_error(const string& what_arg);
    };

    class overflow_error : public runtime_error {
    public:
      overflow_error(const string& what_arg);
    };

// }

#endif // __STDEXCEPT_H
