group{ 'puppet': ensure  => present }

node 'objc-ci.local' {

    # homebrew
    class { 'homebrew': }

    $pkglist = ['xctool', 'appledoc', 'reattach-to-user-namespace']

    package { $pkglist:
        ensure   => installed,
        provider => brew,
    }

    # ssh forwarding
    file { "/Users/vagrant/.ssh/config":
        content => "Host *\n\tForwardAgent yes\nHost github.com\n\tStrictHostKeyChecking no\n",
    }

    file { "/Users/vagrant/.tmux.conf":
        content => 'set-option -g default-command "reattach-to-user-namespace -l bash"',
    }
}