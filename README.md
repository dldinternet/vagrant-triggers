# vagrant-triggers

Allow the definition of arbitrary scripts that will run on the host before and/or after Vagrant commands.

## Installation

Ensure you have downloaded and installed Vagrant from the
[Vagrant downloads page](http://downloads.vagrantup.com/).

Installation is performed in the prescribed manner for Vagrant 1.1+ plugins.

    $ vagrant plugin install vagrant-triggers

## Usage

### Basic usage

The following ```Vagrantfile``` configuration options are added:

```
config.trigger.before :command, :execute => "script"
```

```
config.trigger.after :command, :execute => "script"
```

### Options

* ```:execute => "script"```: the script to execute
* ```:force => true```: continue even if the script fails (exits with non-zero code)
* ```:stdout => true```: display script output

## Example

In the following example a VirtualBox VM (not managed by Vagrant) will be tied to the machine defined in ```Vagrantfile```, to make so that it follows its lifecycle:

```ruby

Vagrant.configure("2") do |config|

  {
    :halt => "controlvm 22aed8b3-d246-40d5-8ad4-176c17552c43 acpipowerbutton",
    :resume => "startvm 22aed8b3-d246-40d5-8ad4-176c17552c43 --type headless",
    :suspend => "controlvm 22aed8b3-d246-40d5-8ad4-176c17552c43 savestate",
    :up => "startvm 22aed8b3-d246-40d5-8ad4-176c17552c43 --type headless"
  }.each do |command, trigger|
    config.trigger.before command, :execute => "vboxmanage #{trigger}", :stdout => true
  end
  
end
```

## Contributing

To contribute, clone the repository, and use [Bundler](http://bundler.io/)
to install dependencies:

    $ bundle

To run the plugin's tests:

    $ bundle exec rake

You can now fork this repository, make your changes and send a pull request.
