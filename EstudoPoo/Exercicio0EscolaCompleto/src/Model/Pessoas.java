package Model;

public abstract class Pessoas {
    //atributos privados (encapsulameto)
    private String nome;
    private String cpf;
    //métodos
    //construtor
    public Pessoas(String nome, String cpf) {
        this.nome = nome;
        this.cpf = cpf;
    }
    //getters and setters
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getCpf() {
        return cpf;
    }
    public void setCpf(String cpf) {
        this.cpf = cpf;
    }
    //método exibir informações
    public void exibirInformacoes(){
        System.out.println("Nome: " + nome);
        System.out.println("CPF: " + cpf);
    }
}
