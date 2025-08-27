import { Component, OnInit } from "@angular/core";
import { DataService } from "../../services/data.service";

@Component({
  selector: "app-posts",
  templateUrl: "./posts.component.html",
  styleUrls: ["./posts.component.scss"],
})
export class PostsComponent implements OnInit {
  mensajes: any;
  constructor(private dataService: DataService) {}
  ngOnInit() {
    console.log("Init");
    this.mensajes = this.dataService.getPosts();
  }

  escuchaClick(id: number) {
    console.log("Click en: ", id);
  }
}
