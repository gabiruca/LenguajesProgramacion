    //Codigo referencia
    
    //Persona 1
    <?php
        $frase1 = " Esta es ";
        $frase2 = "una concatenación.";
        $lista = list($cadena,$frase1,$frase2);

        function concatenacion($lista){
            $concat = "";
            for($i=0;$i<3;$i=$i+1){
                $concat = $concat + $lista[$i];
            }
            print($concat);
        }
        
        /*Monticulos días de mes*/
        $monticulo = new JupilerLeague();
        $monticulo->insert(array('Enero' => 31));
        $monticulo->insert(array('Junio' => 30));
        $monticulo->current();
        $monticulo->compare(31,32);
    ?>
    //Persona 2
    <?php
        public class Persona{
            private $nombre;

            function set_nombre($nombre) {
                $this->nombre = $nombre;
            }
        }
        echo "Mapa de personas";
        $persona1 = new Persona();
        $persona2 = new Persona();
        $persona3 = new Persona();

        $persona1->set_nombre('Juanito');
        $persona2->set_nombre('Andrea');
        $persona3->set_nombre('Ximena');

        $mapa = map([[12345 => $persona1],[12346 => $persona2]]);
        $mapa->put(12347, $persona3);
        $mapa->remove(12346);
        //$mapa->sum();
        
        $numero = 36;
        do{
            $numero = $numero - 1;
        }while($numero>10);
 
    ?>
    //Persona 3
    <?php
        protected $suma = 1.5 + 3.7;
        $cadena = "hola, mundo!";
        private $valor_verdad = true or false;

        if(42 > 17){
            echo "Se cumple el if";
        }else{
            echo "No se cumple el if";
        }

        $array = array(15, 1, 8, 200);
        sort($array);

        function SumarArreglo(array $array){
            $addN = 0;
            foreach($array as $numero){
                $addN = $addN + $numero;
            }
            return $addN;
        }
    ?>
