package provide netif 0.0.1

proc _ssplit {str sep} {
    return [split [string map [list $sep \uFFFF] $str] \uFFFF]
}

set os [string tolower [lindex $tcl_platform(os) 0]]
set dir [file dirname [info script]]
source [file join $dir netif-$os.tcl]
