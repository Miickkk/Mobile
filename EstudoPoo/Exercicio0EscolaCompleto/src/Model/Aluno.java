package Model;

public class Aluno extends Pessoas implements Avaliavel {
    //atributos
    private String matricula;
    private double nota;
    //construtor
    public Aluno(String nome, String cpf, String matricula, double nota) {
        super(nome, cpf);
        this.matricula = matricula;
        this.nota = nota;
    }
    //getter and setters
    public String getMatricula() {
        return matricula;
    }
    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
    public double getNota() {
        return nota;
    }
    public void setNota(double nota) {
        this.nota = nota;
    }
    //exibir informações - Sobreescrita
    public void exibirInformacoes() {
        super.exibirInformacoes();
        System.out.println("Matricula: " + matricula);
        System.out.println("Nota: " + nota);
    }
    //Avaliável
    @Override
    public void avaliarDesempenho() {
        if (nota >= 6.0) {
            System.out.println("Aluno aprovado.");
        } else {
            System.out.println("Aluno reprovado.");
        }
    }

    
}
