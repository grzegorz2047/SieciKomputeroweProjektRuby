# SieciKomputeroweProjektRuby

           Tresc zadania projektu:

                Sieci komputerowe – projekt

                Gracze są klientami, którzy łączą się z serwerem.
                Serwer przechowuje informacje o grze.
                Gracze komunikują się z serwerem za pomocą komend tekstowych. Interfejs gry może być wzorowany np. na tym.
                Aplikacja powinna umożliwiać jednoczesną grę wielu parom graczy.
                Proszę skupić się raczej na poprawnej implementacji architektury (klient–serwer) niż na poprawnej implementacji mechanizmów gry.
                Preferowany język: C/C++ (ale można napisać również w innym języku, jeśli ktoś woli).

                Przydatne linki:
                    https://pl.wikipedia.org/wiki/Szachowa_notacja_algebraiczna
                    https://github.com/marcusbuffett/command-line-chess

                Moje przemyslenia:

                W głównym ekranie wybierasz czy jesteś serwerem czy clientem.
                W następnym ekranie Podajesz adres ip, port oraz jeżeli jest to client to wpisujesz nazwę gracza.
                Jeżeli jest to serwer, to:
                    - nasłuchuje czy jakiś klient chce się połaczyć
                    - Może być wiele "pokoi"
                    - może być klasa od pokoju
                    - może być klasa od clienta
                    - może być klasa od nasluchiwania polaczen
                    - może być klasa od trzymania watku
                    - może być klasa od puli watków
                    - co będzie gdy 2 watki beda chcialy dostep do 1 wartosci (modyfikacja itd.)
                    -

                Jeżeli jest to client, to:
                    - może stworzyć pokój na grę
                    - może dołaczyc do pokoju
                        Jeżeli dołaczy do pokoju, to:
                            -   pojawia się okno z "logiem" oraz pole gdzie wpisuje się pozycje ruchu?
                                Musi być jakieś zabezpieczenie przed wykonaniem ruchu "na przód"
                                Co jeśli gracz się rozłaczy
                                Co jeśli hostujacy sie rozlaczy (co dzieje sie z pustym "pokojem")

