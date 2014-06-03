proc netif {} {
    proc ssplit {str sep} {
        return [split [string map [list $sep \uFFFF] $str] \uFFFF]
    }
    set ifconfig [exec /sbin/ifconfig]
    set ifstrs [ssplit $ifconfig \n\n]
    set ans [dict create]
    foreach ifstr $ifstrs {
        set pattern {^(\S+).*inet addr:\s*(\S+)}
        if {[regexp $pattern $ifstr _ ifnam ifaddr]} {
            dict set ans $ifnam $ifaddr
        } else {
            error {Device has no address}
        }
    }
    return $ans
}
