group{ 'puppet': ensure  => present }

node 'objc-ci.local' {

    # homebrew
    class { 'homebrew': }

    $pkglist = ['xctool', 'appledoc']

    package { $pkglist:
        ensure   => installed,
        provider => brew,
    }

    # ssh forwarding
    file { "/Users/vagrant/.ssh/config":
        content => "Host *\n\tForwardAgent yes\nHost github.com\n\tStrictHostKeyChecking no\n",
    }
}
