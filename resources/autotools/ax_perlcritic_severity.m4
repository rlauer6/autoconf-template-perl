AC_DEFUN([AX_PERLCRITIC_CONFIG],[
    AC_ARG_WITH(
    	[perlcritic-severity],[  --with-perlcritic-severity=severity],
    	[perlcritic_severity=$withval],
        [perlcritic_severity=1]
    	)

   AC_SUBST([perlcritic_severity])
])
