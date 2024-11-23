namespace eval proj {
    proc sum_two_numbers {n1 n2} {
      return [expr $n1 + $n2]
    }
    
    proc handle_named_args {args} {
      array set options {
          -base_folder ""
          -target_folder ""
      }
    
      array set options $args
  
      set base_folder ""
      
      if {[string length $options(-base_folder)] == 0} {
          set base_folder "."
      } else {
          set base_folder [file normalize $options(-base_folder)]
      }
  
      return [file join $base_folder $options(-target_folder)]
    }

    proc gen_range_list {start end} {
        set range_list {}
        for {set i $start} {$i < $end} {incr i} {
            lappend range_list $i
        }
        return $range_list
    }

    proc print_list {num_list} {
        foreach num $num_list {
            puts $num
        }
    }

    proc run {} {
        # Call sum_numbers
        puts "Sum of 3 and 5: [sum_two_numbers 3 5]"

        # Call handle_named_args
        set base_and_target [handle_named_args -base_folder "/home/user" -target_folder "documents"]
        puts "Combined folder path: $base_and_target"

        # Call generate_range
        set range [gen_range_list 1 10]
        puts "Generated range: $range"

        # Call print_list
        puts "Printing range:"
        print_list $range
    }
}

proj::run