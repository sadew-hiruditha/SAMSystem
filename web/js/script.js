
                $(".navbar-toggler").click(function () {
                    $("#sidebar").toggleClass("show");
                });

                // Close sidebar when clicking outside on mobile
                $(document).click(function (event) {
                    if (!$(event.target).closest('#sidebar, .navbar-toggler').length) {
                        $("#sidebar").removeClass("show");
                    }
                });