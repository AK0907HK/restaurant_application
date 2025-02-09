module ApplicationHelper
    def tailwind_pagination(collection)
      will_paginate(collection, class: "pagination", previous_label: "<", next_label: ">")
    end
  end
  